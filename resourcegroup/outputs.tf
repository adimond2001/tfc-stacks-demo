output "infra_rg_name" {
  description = "The name of the resource group conataining infrastructure resources"
  value       = module.avm-res-resources-resourcegroup_infra.name
}

output "network_rg_name" {
  description = "The name of the resource group conataining networking resources"
  value       = module.avm-res-resources-resourcegroup_network.name
}
