locals {
  name = var.prefix
}

module "avm-res-compute-virtualmachine" {
  source  = "Azure/avm-res-compute-virtualmachine/azurerm"
  version = "0.18.1"

  location            = var.location
  name                = "${local.name}-compute-vm-01"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  computer_name              = "compute01"
  zone                       = 1
  os_type                    = "Windows"
  sku_size                   = var.vm_sku_size
  encryption_at_host_enabled = false

  generated_secrets_key_vault_secret_config = {
    key_vault_resource_id = var.keyvault01_id
    secret_name           = "vm01password"
  }

  managed_identities = {
    system_assigned = true
  }

  source_image_reference = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-g2"
    version   = "latest"
  }

  network_interfaces = {
    network_interface_1 = {
      name = "${local.name}-compute01-nic-01"
      ip_configurations = {
        ip_configuration_1 = {
          name                          = "ipconfig01"
          private_ip_subnet_resource_id = var.vm_subnet_id
        }
      }

      diagnostic_settings = {
        nic_diags = {
          name                  = "NetworkInterface01DiagnosticSettings"
          workspace_resource_id = var.laworkspace_id
          metric_categories     = ["AllMetrics"]
        }
      }
    }
  }

  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  diagnostic_settings = {
    vm_diags = {
      name                  = "VirtualMachine01DiagnosticSettings"
      workspace_resource_id = var.laworkspace_id
      metric_categories     = ["AllMetrics"]
    }
  }

  extensions = {
    azure_monitor_agent = {
      name                       = "AzureMonitorWindowsAgent"
      publisher                  = "Microsoft.Azure.Monitor"
      type                       = "AzureMonitorWindowsAgent"
      type_handler_version       = "1.2"
      auto_upgrade_minor_version = true
      automatic_upgrade_enabled  = true
      settings                   = null
    }
    azure_disk_encryption = {
      name                       = "AzureDiskEncryption"
      publisher                  = "Microsoft.Azure.Security"
      type                       = "AzureDiskEncryption"
      type_handler_version       = "2.2"
      auto_upgrade_minor_version = true
      settings                   = <<SETTINGS
          {
              "EncryptionOperation": "EnableEncryption",
              "KeyVaultURL": "${var.keyvault01_uri}",
              "KeyVaultResourceId": "${var.keyvault01_id}",
              "KeyEncryptionAlgorithm": "RSA-OAEP",
              "VolumeType": "All"
          }
      SETTINGS
    }
  }

}

resource "azurerm_monitor_data_collection_rule" "test" {
  location            = var.location
  name                = "${module.avm-res-compute-virtualmachine.name}-dcr"
  resource_group_name = var.resource_group_name
  tags                = var.tags

  data_flow {
    destinations = [var.laworkspace_name]
    streams      = ["Microsoft-Event", "Microsoft-Perf"]
  }
  destinations {
    log_analytics {
      name                  = var.laworkspace_name
      workspace_resource_id = var.laworkspace_id
    }
  }
  data_sources {
    performance_counter {
      counter_specifiers = [
        "\\Processor Information(_Total)\\% Processor Time",
        "\\Processor Information(_Total)\\% Privileged Time",
        "\\Processor Information(_Total)\\% User Time",
        "\\Processor Information(_Total)\\Processor Frequency",
        "\\System\\Processes",
        "\\Process(_Total)\\Thread Count",
        "\\Process(_Total)\\Handle Count",
        "\\System\\System Up Time",
        "\\System\\Context Switches/sec",
        "\\System\\Processor Queue Length",
        "\\Memory\\% Committed Bytes In Use",
        "\\Memory\\Available Bytes",
        "\\Processor(_Total)\\% Processor Time",
        "\\Memory\\Committed Bytes",
        "\\Memory\\Cache Bytes",
        "\\Memory\\Pool Paged Bytes",
        "\\Memory\\Pool Nonpaged Bytes",
        "\\Memory\\Pages/sec",
        "\\Memory\\Page Faults/sec",
        "\\Process(_Total)\\Working Set",
        "\\Process(_Total)\\Working Set - Private",
        "\\LogicalDisk(_Total)\\% Disk Time",
        "\\LogicalDisk(_Total)\\% Disk Read Time",
        "\\LogicalDisk(_Total)\\% Disk Write Time",
        "\\LogicalDisk(_Total)\\% Idle Time",
        "\\LogicalDisk(_Total)\\Disk Bytes/sec",
        "\\LogicalDisk(_Total)\\Disk Read Bytes/sec",
        "\\LogicalDisk(_Total)\\Disk Write Bytes/sec",
        "\\LogicalDisk(_Total)\\Disk Transfers/sec",
        "\\LogicalDisk(_Total)\\Disk Reads/sec",
        "\\LogicalDisk(_Total)\\Disk Writes/sec",
        "\\LogicalDisk(_Total)\\Avg. Disk sec/Transfer",
        "\\LogicalDisk(_Total)\\Avg. Disk sec/Read",
        "\\LogicalDisk(_Total)\\Avg. Disk sec/Write",
        "\\LogicalDisk(_Total)\\Avg. Disk Queue Length",
        "\\LogicalDisk(_Total)\\Avg. Disk Read Queue Length",
        "\\LogicalDisk(_Total)\\Avg. Disk Write Queue Length",
        "\\LogicalDisk(_Total)\\% Free Space",
        "\\LogicalDisk(_Total)\\Free Megabytes",
        "\\Network Interface(*)\\Bytes Total/sec",
        "\\Network Interface(*)\\Bytes Sent/sec",
        "\\Network Interface(*)\\Bytes Received/sec",
        "\\Network Interface(*)\\Packets/sec",
        "\\Network Interface(*)\\Packets Sent/sec",
        "\\Network Interface(*)\\Packets Received/sec",
        "\\Network Interface(*)\\Packets Outbound Errors",
        "\\Network Interface(*)\\Packets Received Errors",
        "Processor(*)\\% Processor Time",
        "Processor(*)\\% Idle Time",
        "Processor(*)\\% User Time",
        "Processor(*)\\% Nice Time",
        "Processor(*)\\% Privileged Time",
        "Processor(*)\\% IO Wait Time",
        "Processor(*)\\% Interrupt Time",
        "Processor(*)\\% DPC Time",
        "Memory(*)\\Available MBytes Memory",
        "Memory(*)\\% Available Memory",
        "Memory(*)\\Used Memory MBytes",
        "Memory(*)\\% Used Memory",
        "Memory(*)\\Pages/sec",
        "Memory(*)\\Page Reads/sec",
        "Memory(*)\\Page Writes/sec",
        "Memory(*)\\Available MBytes Swap",
        "Memory(*)\\% Available Swap Space",
        "Memory(*)\\Used MBytes Swap Space",
        "Memory(*)\\% Used Swap Space",
        "Process(*)\\Pct User Time",
        "Process(*)\\Pct Privileged Time",
        "Process(*)\\Used Memory",
        "Process(*)\\Virtual Shared Memory",
        "Logical Disk(*)\\% Free Inodes",
        "Logical Disk(*)\\% Used Inodes",
        "Logical Disk(*)\\Free Megabytes",
        "Logical Disk(*)\\% Free Space",
        "Logical Disk(*)\\% Used Space",
        "Logical Disk(*)\\Logical Disk Bytes/sec",
        "Logical Disk(*)\\Disk Read Bytes/sec",
        "Logical Disk(*)\\Disk Write Bytes/sec",
        "Logical Disk(*)\\Disk Transfers/sec",
        "Logical Disk(*)\\Disk Reads/sec",
        "Logical Disk(*)\\Disk Writes/sec",
        "Network(*)\\Total Bytes Transmitted",
        "Network(*)\\Total Bytes Received",
        "Network(*)\\Total Bytes",
        "Network(*)\\Total Packets Transmitted",
        "Network(*)\\Total Packets Received",
        "Network(*)\\Total Rx Errors",
        "Network(*)\\Total Tx Errors",
        "Network(*)\\Total Collisions",
        "System(*)\\Uptime",
        "System(*)\\Load1",
        "System(*)\\Load5",
        "System(*)\\Load15",
        "System(*)\\Users",
        "System(*)\\Unique Users",
        "System(*)\\CPUs",
        "\\PhysicalDisk(_Total)\\Avg. Disk Queue Length",
      ]
      name                          = "exampleCounters"
      sampling_frequency_in_seconds = 60
      streams                       = ["Microsoft-Perf"]
    }
    windows_event_log {
      name    = "eventLogsDataSource"
      streams = ["Microsoft-Event"]
      x_path_queries = ["Application!*[System[(Level=1 or Level=2 or Level=3)]]",
        "Security!*[System[(band(Keywords,4503599627370496))]]",
      "System!*[System[(Level=1 or Level=2 or Level=3)]]"]
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "this_rule_association" {
  target_resource_id      = module.avm-res-compute-virtualmachine.resource_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.test.id
  description             = "test data collection rule association"
  name                    = "${azurerm_monitor_data_collection_rule.test.name}-association"
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
