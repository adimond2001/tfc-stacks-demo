locals {
  location = "uksouth"
  project = "tfstack-testing"
}

identity_token "azurerm" {
  audience = ["api://AzureADTokenExchange"]
}

deployment "dev" {
    inputs = {
        identity_token = identity_token.azurerm.jwt
        # client_id = "09d7c511-4378-42f7-85d0-1994a1bde869"
        # subscription_id = "03f3b267-28f2-4d43-aa90-29bec475f445"
        # tenant_id = "b25b83c2-7aa4-4d52-b0c9-fc813c289693"
        client_id = "b42ce71a-60aa-425b-8668-e910d5daf93f" # CHG-ExchangeOnlineScripting
        subscription_id = "aefd2c68-cd3c-454d-a6b7-21b85430e3d3" # R&D
        tenant_id = "99ef90fc-6e45-47a4-ae28-3916483dc9f2" # Azure Main

        location = local.location
        prefix = "tfstack"
        suffix = "644547"
        cidr_range = "10.0.0.0/16"
        subnets = {
            subnet1 = ["10.0.0.0/24"]
            subnet2 = ["10.0.1.0/24"]
        }
        tags = {
            Environment = "Development"
            project = local.project
        }
    }
}