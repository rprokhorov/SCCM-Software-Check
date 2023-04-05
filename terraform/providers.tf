terraform {
  cloud {
    organization = "rprokhorov"

    workspaces {
      name = "SCCM-Software-Check"
    }
  }
}
provider "azurerm" {
  features {}
}