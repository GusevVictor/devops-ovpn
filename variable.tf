// Google cloud vars

variable "gcp_region" {
  description = "Google cloud provider region"
  type        = string
  sensitive   = true
}

variable "gcp_project_name" {
  description = "Google cloud project name"
  type        = string
  sensitive   = true
}

variable "gcp_zone" {
  description = "Google cloud provider zone name"
  type        = string
  sensitive   = true
}

// Yandex cloud vars

variable "yc_token" {
  description = "Yandex cloud token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex cloud id"
  type        = string
  sensitive   = true
}

variable "yc_folder_id" {
  description = "Yandex cloud folder id"
  type        = string
  sensitive   = true
}

variable "yc_zone" {
  description = "Yandex cloud zone"
  type        = string
  sensitive   = true
}

