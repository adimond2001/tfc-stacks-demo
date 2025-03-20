variable "prefix" {
  description = "Prefix for the resources"
  type        = string
}

variable "resource_group_name" {
  type        = string
  description = "Name of Resource Group where resource will be placed"
}

variable "location" {
  type        = string
  description = "Location (Region) where Bastion will be placed"
}

variable "tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}

variable "vm_subnet_id" {
  type        = string
  description = "ID of the subnet the Bastion will be associated with"
}

variable "public_ip_address01_id" {
  type        = string
  description = "ID of the subnet the Bastion will be associated with"
}
