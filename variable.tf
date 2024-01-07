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
