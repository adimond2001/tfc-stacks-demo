output "laworkspaceid" {
  description = "value of the Log Analytics Workspace ID"
  value       = module.avm-res-operationalinsights-workspace.resource_id
}

output "laworkspace_name" {
  description = "value of the Log Analytics Workspace Name"
  value       = module.avm-res-operationalinsights-workspace.resource.name
}
