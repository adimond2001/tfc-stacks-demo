locals {
  name = "${var.prefix}-network01"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name}-rg"
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "main" {
  name                = "${local.name}-vnet01"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = [var.cidr_range]

  tags = var.tags
}

resource "azurerm_subnet" "main" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = each.value
}
