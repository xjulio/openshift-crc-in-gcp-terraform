variable "project" {
  description = "GCP Project"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "GCP Compute instance name"
  type        = string
}

variable "machine_type" {
  description = "GCP Compute machine type"
  type        = string
}

variable "image" {
  description = "GCP Compute machine image"
  type        = string
}

variable "disk_size" {
  description = "The size of the image in gigabytes."
  type        = number
}

variable "network" {
  description = "GCP network to launch the instance."
  type        = string
  default     = "default"
}

variable "pull_secrets" {
  description = "OpenShift Pull Secrets file location."
  type        = string
}
