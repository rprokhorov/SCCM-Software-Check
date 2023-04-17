locals {
  container_name = {
    "7zip"                = "7-zip"
    "axurepr"             = "AxurePR"
    "farmanager"          = "Far Manager"
    "fiddler"             = "Fiddler"
    "filezilla"           = "FileZilla"
    "git"                 = "Git"
    "gitextentions"       = "Git Extentions"
    "klitestandard"       = "K-Lite Standard"
    "keepass"             = "KeePass"
    "mozillafirefox"      = "Mozilla Firefox"
    "notepad"             = "Notepad++"
    "postman"             = "Postman"
    "putty"               = "Putty"
    "rdcman"              = "RDCMan"
    "rdtabs"              = "RDTabs"
    "sqlmanagementstudio" = "SQL management Studio"
    "totalcommander"      = "Total Commander"
    "vlc"                 = "VLC"
    "visualstudiocode"    = "Visual Studio Code"
    "winrar"              = "WinRAR"
    "winscp"              = "WinSCP"
    "wireshark"           = "Wireshark"
    "mremoteng"           = "mRemoteNG"
    "nmap"                = "nmap"
  }
  zonedips-list = flatten([
    for container_name, folder_name in local.container_name : [
      for file in fileset("${path.module}/../JSONs/${folder_name}", "**") : {
        file_name      = file
        container_name = "${container_name}"
        folder_name    = "${folder_name}"
        file_path      = "${file}"
      }
    ]
  ])
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.azurerm_resource_group.name
  location = var.azurerm_resource_group.location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.azurerm_storage_account.name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "storage_container" {
  for_each              = local.container_name
  name                  = each.key
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "tamopsblobs" {
  count                  = length(local.zonedips-list)
  name                   = local.zonedips-list[count.index].file_name
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.storage_container[local.zonedips-list[count.index].container_name].name
  type                   = "Block"
  source                 = "../JSONs/${local.zonedips-list[count.index].folder_name}/${local.zonedips-list[count.index].file_name}"
}

resource "azurerm_app_service_plan" "app_service_plan" {
  name                = var.azurerm_app_service_plan.name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  kind                = "FunctionApp"
  reserved            = true
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_linux_function_app" "function_app" {
  name                = var.azurerm_linux_function_app.name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  storage_account_name       = azurerm_storage_account.storage_account.name
  storage_account_access_key = azurerm_storage_account.storage_account.primary_access_key
  service_plan_id            = azurerm_app_service_plan.app_service_plan.id

  site_config {
    application_stack {
      powershell_core_version = "7.2"
    }
  }
}

resource "azurerm_function_app_function" "httpTrigger" {
  name            = "application"
  function_app_id = azurerm_linux_function_app.function_app.id
  language        = "PowerShell"

  file {
    name    = "run.ps1"
    content = file("${path.module}/../azure_functions/http_trigger_run.ps1")
  }

  file {
    name    = "../Modules/software-check/software-check.psd1"
    content = file("${path.module}/../Modules/software-check/software-check.psd1")
  }
  file {
    name    = "../Modules/software-check/software-check.psm1"
    content = file("${path.module}/../Modules/software-check/software-check.psm1")
  }

  test_data = jsonencode({
    "name" = "git"
  })

  config_json = jsonencode({
    "bindings" : [
      {
        "authLevel" : "anonymous",
        "type" : "httpTrigger",
        "direction" : "in",
        "name" : "Request",
        "methods" : [
          "get",
          "post"
        ]
      },
      {
        "type" : "http",
        "direction" : "out",
        "name" : "Response"
      }
    ]
  })
}

resource "azurerm_function_app_function" "timerTrigger" {
  name            = "application"
  function_app_id = azurerm_linux_function_app.function_app.id
  language        = "PowerShell"

  file {
    name    = "run.ps1"
    content = file("${path.module}/../azure_functions/timer_trigger.ps1")
  }


  config_json = jsonencode({
    "bindings" : [
      {
        "name" : "Timer",
        "type" : "timerTrigger",
        "direction" : "in",
        "schedule" : "0 */5 * * * *"
      }
    ]
  })
}
