# variables.tf

variable "HCP_CLIENT_ID" {
  description = "HCP Client ID"
  type        = string
  sensitive   = true
}

variable "HCP_CLIENT_SECRET" {
  description = "HCP Client Secret"
  type        = string
  sensitive   = true
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "workload_suffix" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vm_sku_size" {
  type = string
}