data "azurerm_client_config" "current" {}

# Define a Key Vault
resource "azurerm_key_vault" "kv01" {
  name                        = "${var.base_name}-kv-01"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  purge_protection_enabled    = false
  tags                        = var.tags
  sku_name                    = "standard"
}

# Deploy a Key Vault Access Policy with only secret permissions granted 
# to the group: GBL_SEC_GCP_CE
resource "azurerm_key_vault_access_policy" "kvap01" {
  key_vault_id = azurerm_key_vault.kv01.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_id_CET
  depends_on   = [azurerm_key_vault.kv01]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]
}

# Deploy a Key Vault Access Policy with only secret permissions granted 
# to the Azure Enterprise Application: SREApps
resource "azurerm_key_vault_access_policy" "kvap02" {
  key_vault_id = azurerm_key_vault.kv01.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.object_id_AzAppReg01
  depends_on   = [azurerm_key_vault.kv01]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
  ]
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
