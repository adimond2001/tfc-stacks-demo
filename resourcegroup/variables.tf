variable "prefix" {
  description = "Prefix for the resources"
  type        = string
}

variable "location" {
  type        = string
  description = "Location (Region) where Bastion will be placed"
}

variable "tags" {
  description = "Tags to set for all resources"
  type        = map(string)
}
