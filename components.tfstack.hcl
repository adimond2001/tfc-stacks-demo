component "network" {
  source = "./network"

  inputs = {
    location   = var.location
    prefix     = var.prefix
    cidr_range = var.cidr_range
    subnets    = var.subnets
    tags       = var.tags
  }

  providers = {
    azurerm = provider.azurerm.this
  }
}

component "vm" {
  source = "./vm"

  inputs = {
    location     = var.location
    prefix       = var.prefix
    vm_subnet_id = component.network.subnet_ids[1]
    tags         = var.tags
  }

  providers = {
    azurerm = provider.azurerm.this
    tls     = provider.tls.this
    random  = provider.random.this
    modtm   = provider.modtm.this
  }
}

# component "bastionhost" {
#     source = "./bastionhost"

#     inputs = {
#         location = var.location
#         tags = var.tags
#     }

#     providers = {
#         azurerm = provider.azurerm.this
#     }

# }

component "keyvault" {
  source = "./keyvault"

  inputs = {
    location            = var.location
    tenant_id           = var.tenant_id
    resource_group_name = component.vm.resource_group_name
    prefix              = var.prefix
    kv_sku_name         = "standard"
    tags                = var.tags
    kv-ap-objid01       = "d64b88a4-c3dd-47e0-817f-b3057e0b3029" # Azure AD Object ID: Alan Dimond
    kv-ap-objid02       = "a14ec4d0-c6c9-4fd9-836b-9fa261eed5ee" # Azure App Registration ID: tfc-application
  }

  providers = {
    azurerm = provider.azurerm.this
    random  = provider.random.this
    modtm   = provider.modtm.this
    time    = provider.time.this
  }
}

# component "database" {
#     source = "./database"

#     inputs = {
#         location = var.location
#         prefix = var.prefix
#         suffix = var.suffix
#         tags = var.tags
#     }

#     providers = {
#         azurerm = provider.azurerm.this
#         random = provider.random.this
#         modtm = provider.modtm.this
#     }

#     depends_on = [component.vm]
# }