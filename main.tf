terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.28.0"
    }
  }

  required_version = ">= v1.2.0"
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_address" "static_ip" {
  name = var.instance_name
}

resource "google_compute_firewall" "allow_crc" {
  name          = "allow-crc"
  network       = var.network
  target_tags   = ["allow-crc"]
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22", "443", "80", "6443"]
  }
}

data "template_file" "startup" {
  template = file("${path.module}/scripts/startup.sh")
  vars = {
    HAPROXY_CFG  = file("${path.module}/scripts/haproxy.cfg")
    CRC_SETUP    = file("${path.module}/scripts/setup.sh")
    PULL_SECRETS = filebase64(var.pull_secrets)
  }
}

resource "google_compute_instance" "vm_instance" {
  name                    = var.instance_name
  machine_type            = var.machine_type
  zone                    = var.zone
  can_ip_forward          = true
  metadata_startup_script = data.template_file.startup.rendered
  tags                    = ["http-server", "https-server", "allow-crc"]

  advanced_machine_features {
    enable_nested_virtualization = true
  }

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
      type  = "pd-ssd"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }
}

// Terraform plugin for creating random IDs
resource "random_id" "instance_id" {
  byte_length = 8
}
