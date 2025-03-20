locals {
  name = var.prefix
}

module "avm-res-resources-resourcegroup_infra" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name             = "${local.name}-infra-rg"
  location         = var.location
  tags             = var.tags
  enable_telemetry = true
  #   role_assignments = {
  #     "roleassignment1" = {
  #       principal_id               = azurerm_user_assigned_identity.dep_uai.principal_id
  #       role_definition_id_or_name = "Reader"
  #     }
  #   }
}

module "avm-res-resources-resourcegroup_network" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.2.1"

  name     = "${local.name}-network-rg"
  location = var.location
  tags     = var.tags

  enable_telemetry = true
  #   role_assignments = {
  #     "roleassignment1" = {
  #       principal_id               = azurerm_user_assigned_identity.dep_uai.principal_id
  #       role_definition_id_or_name = "Reader"
  #     }
  #   }
}
