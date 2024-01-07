terraform {
  required_providers {
    google = {
      version = "~> 5.3.0"
    }
  }
}
  provider "google" {
    region      = var.gcp_region
    project     = var.gcp_project_name
    credentials = file("google_service_account.tfvars.json")
    zone        = var.gcp_zone
}
