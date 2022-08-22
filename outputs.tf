output "public_ip" {
  value = google_compute_address.static_ip.address
}

output "private_ip" {
  value = google_compute_instance.vm_instance.network_interface.0.network_ip
}
