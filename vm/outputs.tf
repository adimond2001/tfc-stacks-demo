output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

# output "vm_id" {
#   value = module.testvm01.resource_id
# }

# output "vm_resource" {
#   value     = module.testvm01.resource
#   sensitive = true
# }
