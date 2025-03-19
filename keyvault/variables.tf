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

variable "kv_sku_name" {
  description = "Size of the VM"
  type        = string
  default     = "Standard"
}

variable "kv-ap-objid01" {
  description = "Azure Entra ObjectID for a Key Vault access policy"
  type        = string
}

variable "kv-ap-objid02" {
  description = "Azure Entra ObjectID for a Key Vault access policy"
  type        = string
}

variable "workspace_resource_id" {
  description = "Azure Entra ObjectID for a Key Vault access policy"
  type        = string
}
