azurerm_resource_group = {
  name     = "sccm-software-check-rg"
  location = "West Europe"
}

azurerm_storage_account = {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  name                     = "sccmsoftwarecheckstorage"
}

azurerm_app_service_plan = {
  name     = "sccm-software-check-app-service-plan"
  os_type  = "Linux"
  sku_name = "P1v2"
}

azurerm_linux_function_app = {
  name = "sccm-software-check"
}
