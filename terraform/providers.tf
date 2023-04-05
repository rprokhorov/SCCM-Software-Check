# terraform {
#   cloud {
#     organization = "rprokhorov"

#     workspaces {
#       name = "SCCM-Software-Check"
#     }
#   }
# }

terraform {
  backend "azurerm" {
    key                  = "sccm-software-check.tfstate"
    resource_group_name  = "permanent"
    storage_account_name = "klo"
    container_name       = "terraform"
  }
}
provider "azurerm" {
  features {}
}