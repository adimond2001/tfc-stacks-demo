locals {
  location = "uksouth"
  prefix1 = "az-p"
  prefix2 = "az-t"
  prefix3 = "az-d"
  name = "tfstack"
}

identity_token "azurerm" {
  audience = ["api://AzureADTokenExchange"]
}

deployment "dev" {
    inputs = {
        identity_token = identity_token.azurerm.jwt
        client_id = "09d7c511-4378-42f7-85d0-1994a1bde869" # Azure App Registration: tfc-application
        subscription_id = "03f3b267-28f2-4d43-aa90-29bec475f445" # Development subscription
        tenant_id = "b25b83c2-7aa4-4d52-b0c9-fc813c289693" # Alan's tenant

        location = local.location
        prefix = "${local.prefix3}-${local.name}"
        suffix = "01"
        cidr_range = "10.0.0.0/16"
        subnets = {
            AzureBastionSubnet = ["10.0.0.0/24"]
            "${local.prefix3}-${local.name}-snet-01" = ["10.0.1.0/24"]
        }
        tags = {
            Application      = "CET Sandbox Environment"
            Businessunit     = "IT"
            Contact          = "Cloud Engineering Team"
            Customer         = "Cloud Services"
            Department       = "Cloud Services"
            DisasterRecovery = "No"
            Environment      = "Development"
            CostCentre       = "90IMT"
            CreatedBy        = "Alan Dimond"
            TerraformManaged = "Yes"
        }
    }
}