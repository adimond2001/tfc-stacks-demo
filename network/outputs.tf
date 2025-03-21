output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  value = [for subnet in azurerm_subnet.main : subnet.id]
}

# output "subnet_map" {
#   value = { for subnet in azurerm_subnet.main : subnet.name => subnet }
# }

output "pip01_publicip_id" {
  value = module.avm-res-network-publicipaddress01.public_ip_id
}
