component "resource_group" {
  source = "./resourcegroup"

  inputs = {
    location = var.location
    prefix   = var.prefix
    tags     = var.tags
  }

  providers = {
    azurerm = provider.azurerm.this
    modtm   = provider.modtm.this
    random  = provider.random.this
  }
}

component "network" {
  source = "./network"

  inputs = {
    location            = var.location
    prefix              = var.prefix
    resource_group_name = component.resource_group.network_rg_name
    cidr_range          = var.cidr_range
    subnets             = var.subnets
    tags                = var.tags
  }

  providers = {
    azurerm = provider.azurerm.this
    modtm   = provider.modtm.this
    random  = provider.random.this
  }
  depends_on = [component.resource_group]
}

component "compute" {
  source = "./compute"

  inputs = {
    location            = var.location
    prefix              = var.prefix
    resource_group_name = component.resource_group.infra_rg_name
    tags                = var.tags
    vm_subnet_id        = component.network.subnet_ids[1]
    laworkspace_id      = component.monitoring.laworkspaceid
    laworkspace_name    = component.monitoring.laworkspace_name
    keyvault01_id       = component.keyvault.keyvault01_id
    keyvault01_uri      = component.keyvault.keyvault01_uri
  }

  providers = {
    azurerm = provider.azurerm.this
    tls     = provider.tls.this
    modtm   = provider.modtm.this
    random  = provider.random.this
    azapi   = provider.azapi.this
  }
  depends_on = [component.resource_group, component.network, component.keyvault, component.monitoring]
}

component "bastionhost" {
  source = "./bastionhost"

  inputs = {
    location               = var.location
    prefix                 = var.prefix
    resource_group_name    = component.resource_group.infra_rg_name
    tags                   = var.tags
    vm_subnet_id           = component.network.subnet_ids[1]
    public_ip_address01_id = component.network.pip01_publicip_id

  }

  providers = {
    azurerm = provider.azurerm.this
    modtm   = provider.modtm.this
    random  = provider.random.this
  }
  depends_on = [component.resource_group, component.network]
}

component "keyvault" {
  source = "./keyvault"

  inputs = {
    location            = var.location
    tenant_id           = var.tenant_id
    resource_group_name = component.resource_group.infra_rg_name
    prefix              = var.prefix
    kv_sku_name         = "standard"
    tags                = var.tags
    kv-ap-objid01       = "d64b88a4-c3dd-47e0-817f-b3057e0b3029" # Azure AD Object ID: Alan Dimond
    kv-ap-objid02       = "a14ec4d0-c6c9-4fd9-836b-9fa261eed5ee" # Azure App Registration ID: tfc-application
    laworkspace_id      = component.monitoring.laworkspaceid
  }

  providers = {
    azurerm = provider.azurerm.this
    modtm   = provider.modtm.this
    time    = provider.time.this
    random  = provider.random.this
  }
  depends_on = [component.resource_group]
}

component "monitoring" {
  source = "./monitoring"

  inputs = {
    location            = var.location
    tenant_id           = var.tenant_id
    resource_group_name = component.resource_group.infra_rg_name
    prefix              = var.prefix
    tags                = var.tags
  }

  providers = {
    azurerm = provider.azurerm.this
    modtm   = provider.modtm.this
    azapi   = provider.azapi.this
    random  = provider.random.this
  }
  depends_on = [component.resource_group, component.network]
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