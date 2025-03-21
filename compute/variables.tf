variable "prefix" {
  description = "Prefix for the resources"
  type        = string
}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Name of Resource Group where resource will be placed"
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(string)
}

variable "vm_sku_size" {
  description = "Size of the VM"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_zone" {
  description = "Zone for the VM"
  type        = string
  default     = "1"
}

variable "vm_subnet_id" {
  description = "Subnet ID for the VM"
  type        = string
}

variable "laworkspace_id" {
  description = "ID of Log Analytics Workspace"
  type        = string
}

variable "laworkspace_name" {
  description = "Name of Log Analytics Workspace"
  type        = string
}

variable "keyvault01_id" {
  description = "ID of Key Vault"
  type        = string
}

variable "keyvault01_uri" {
  description = "URI of Key Vault"
  type        = string
}
