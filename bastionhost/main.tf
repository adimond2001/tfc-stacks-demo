data "azurerm_client_config" "current" {}

locals {
  prefix = var.prefix
}

resource "azurerm_bastion_host" "bastionhost01" {
  name                = "${local.prefix}-bas01"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  copy_paste_enabled  = true
  file_copy_enabled   = true
  sku                 = "Standard"

  ip_configuration {
    name                 = "ipconfig01"
    subnet_id            = var.vm_subnet_id
    public_ip_address_id = var.public_ip_address01_id
  }
}
