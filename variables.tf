variable "azurerm_resource_group" {
  type = object({
    name    = string
    location = string
  })
}

variable "azurerm_storage_account" {
  type = object({
    name    = string
    account_tier = string
    account_replication_type = string
  })
}

variable "azurerm_app_service_plan" {
  type = object({
    name    = string
    os_type = string
    sku_name = string
  })
}

variable "azurerm_linux_function_app" {
  type = object({
    name    = string
  })
}
