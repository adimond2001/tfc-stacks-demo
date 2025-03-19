locals {
  name = var.prefix
}

module "avm-res-operationalinsights-workspace" {
  source  = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version = "0.4.2"

  location                                  = var.location
  name                                      = "${local.name}-law-01"
  resource_group_name                       = var.resource_group_name
  tags                                      = var.tags
  enable_telemetry                          = true
  log_analytics_workspace_retention_in_days = 30
  log_analytics_workspace_sku               = "PerGB2018"
  log_analytics_workspace_identity = {
    type = "SystemAssigned"
  }
}
