terraform {
  required_providers {
    google = {
      version = "~> 5.3.0"
    }
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.104.0"
    }
  }
}
  provider "google" {
    region      = var.gcp_region
    project     = var.gcp_project_name
    credentials = file("google_service_account.tfvars.json")
    zone        = var.gcp_zone
}
  provider "yandex" {
    token     = var.yc_token
    cloud_id  = var.yc_cloud_id
    folder_id = var.yc_folder_id 
    zone      = var.yc_zone
}
