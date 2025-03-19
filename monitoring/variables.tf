variable "prefix" {
  description = "Prefix for the resources"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}

variable "resource_group_name" {
  description = "Resource Group Name for the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for the Key Vault"
  type        = string
}
