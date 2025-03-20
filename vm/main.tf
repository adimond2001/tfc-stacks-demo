locals {
  name = var.prefix
}

module "avm-res-compute-virtualmachine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.18.1"

  location            = var.location
  name                = "${local.name}-compute-vm-01"
  resource_group_name = var.resource_group_name
  network_interfaces  = []
  zone                = 1
  tags                = var.tags
}

# module "testvm01" {
#   source  = "Azure/avm-res-compute-virtualmachine/azurerm"
#   version = "0.16.0"

#   location                           = azurerm_resource_group.main.location
#   name                               = "${local.name}-vm-01"
#   resource_group_name                = var.resource_group_name
#   tags = var.tags
#   admin_username                     = "azureuser"
#   disable_password_authentication    = false
#   enable_telemetry                   = true
#   encryption_at_host_enabled         = false
#   generate_admin_password_or_ssh_key = true
#   os_type                            = "Linux"
#   sku_size                           = var.vm_sku_size
#   zone                               = var.vm_zone


#   network_interfaces = {
#     network_interface_1 = {
#       name = "${local.name}-nic1"
#       ip_configurations = {
#         ip_configuration_1 = {
#           name                          = "${local.name}-ipconfig1"
#           private_ip_subnet_resource_id = var.vm_subnet_id
#         }
#       }
#     }
#   }

#   os_disk = {
#     caching              = "ReadWrite"
#     storage_account_type = "Premium_LRS"
#   }

#   source_image_reference = {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-focal"
#     sku       = "20_04-lts-gen2"
#     version   = "latest"
#   }

# }
