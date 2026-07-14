terraform {
  backend "azurerm" {
    resource_group_name  = "rg-bootstrap"
    storage_account_name = "tfstateagent12345678"
    container_name       = "tfstate"
    key                  = "bootstrap.tfstate"
  }
}