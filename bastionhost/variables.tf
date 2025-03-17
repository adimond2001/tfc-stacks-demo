variable "base_name" {
  type        = string
  description = "Base name of Bastion Host"
}

variable "resource_group_name" {
  type        = string
  description = "Name of Resource Group where Bastion will be placed"
}

variable "location" {
  type        = string
  description = "Location (Region) where Bastion will be placed"
}

variable "object_id_CET" {
  type        = string
  description = "Object ID of group: GBL_SEC_GCP_CE. Fur use in a Key Vault Access Policy"
}

variable "object_id_AzAppReg01" {
  type        = string
  description = "Object ID of Azure Enterprise Application: SREApps. For use in a Key Vault Access Policy and role assignments"
}

variable "compute_admin_username" {
  type        = string
  description = "Admin username for VMs"
}

variable "compute_admin_password" {
  type        = string
  description = "Admin password for VMs"
  sensitive   = true
}

variable "tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}
