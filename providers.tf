provider "azurerm" {
  features {}
  #alias = version
  client_id       = "ae26f68d-c936-453a-8671-771925541541"
  client_secret   = "dqY8Q~UvS910QCRxQ.6hlR5vj8lyXr23UoBbxbTB"
  tenant_id       = "cea297cb-9bde-428d-9a6e-48fa9c582ed6"
  subscription_id = "2a79f2da-f098-4c8a-8e2a-f426682b1eac"
}
terraform {
  backend "azurerm" {
    resource_group_name  = "example-resources"
    storage_account_name = "sai1241241243"
    container_name       = "vhds"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
  #required_version = "=1.7.4"
}
