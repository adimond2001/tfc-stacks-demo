locals {
  name = var.prefix
}

# Get current context of the deployment
data "azurerm_client_config" "current" {}

# Define a Key Vault
module "avm-res-keyvault-vault" {
  source  = "Azure/avm-res-keyvault-vault/azurerm"
  version = "0.10.0"

  location                       = var.location
  name                           = "${local.name}-kv-01"
  resource_group_name            = var.resource_group_name
  tenant_id                      = var.tenant_id
  tags                           = var.tags
  sku_name                       = var.kv_sku_name
  purge_protection_enabled       = false
  enable_telemetry               = true
  legacy_access_policies_enabled = false # Enables Azure RBAC for Key Vault
  role_assignments = {
    deployment_user_kv_admin01 = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = data.azurerm_client_config.current.object_id
    }
    deployment_user_kv_admin02 = {
      role_definition_id_or_name = "Key Vault Administrator"
      principal_id               = var.kv-ap-objid01
    }
  }
  wait_for_rbac_before_secret_operations = {
    create = "60s"
  }
  #legacy_access_policies_enabled = true # Enables the legacy access policies in the Key Vault
  #   legacy_access_policies = {
  #     kvap01 = {
  #       object_id          = var.kv-ap-objid01
  #       secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  #     }
  #     kvap02 = {
  #       object_id          = var.kv-ap-objid02
  #       secret_permissions = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"]
  #     }
  #   }
}

# # Deploy a Key Vault Secret containing the VM Admin Username
# resource "azurerm_key_vault_secret" "kvs01" {
#   name         = "VM-Admin-Username"
#   value        = var.compute_admin_username
#   key_vault_id = azurerm_key_vault.kv01.id
#   depends_on   = [azurerm_key_vault_access_policy.kvap01, azurerm_key_vault_access_policy.kvap02]
# }

# # Deploy a Key Vault Secret containing the VM Admin Password
# resource "azurerm_key_vault_secret" "kvs02" {
#   name         = "VM-Admin-Password"
#   value        = var.compute_admin_password
#   key_vault_id = azurerm_key_vault.kv01.id
#   depends_on   = [azurerm_key_vault_access_policy.kvap01, azurerm_key_vault_access_policy.kvap02]
# }
