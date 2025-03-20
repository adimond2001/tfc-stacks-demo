locals {
  name = var.prefix

}

resource "azurerm_virtual_network" "main" {
  name                = "${local.name}-vnet-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  address_space       = [var.cidr_range]

}

resource "azurerm_subnet" "main" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = each.value
}

module "avm-res-network-networksecuritygroup01" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.4.0"

  name                = "${local.name}-nsg-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  enable_telemetry    = true
  #security_rules      = local.nsg_rules

}

# # Associate NSG with a subnet
# resource "azurerm_subnet_network_security_group_association" "nsga" {
#   for_each                  = azurerm_subnet.main
#   subnet_id                 = azurerm_subnet.main[each.key].inbound
#   ne
# }

module "avm-res-network-publicipaddress01" {
  source  = "Azure/avm-res-network-publicipaddress/azurerm"
  version = "0.2.0"

  name                = "${local.name}-ip-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
  enable_telemetry    = true
  allocation_method   = "Static"
  sku                 = "Standard"
}
