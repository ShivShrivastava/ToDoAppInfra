terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  # tenant_id       = "d434d77a-4443-4924-a756-fac4099fb53b"
  subscription_id = "45d2c8fb-faba-4dc1-ab43-5ad9451eef1c"
}