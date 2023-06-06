variable "FUNCTION_APP_NAME" {}
variable "FUNCTION_APP_SERV_PLAN_NAME" {}
variable "RESOURCE_GROUP_NAME" {}
variable "LOCATION" {}
variable "VNET_NAME" {}
variable "SUBNET_NAME" {}
variable "STORAGE_ACC_NAME" {}
variable "STORAGE_ACC_ACCESS_KEY" {}
variable "STORAGE_ACC_ID" {}
variable "ACR_LOGIN_SERVER" {}


# Create the Function App
resource "azurerm_linux_function_app" "appfunc" {
  name                = var.FUNCTION_APP_NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME
  service_plan_id      = azurerm_service_plan.appservplan.id
  storage_account_name = var.STORAGE_ACC_NAME
  storage_account_access_key = var.STORAGE_ACC_ACCESS_KEY

site_config {
    always_on              = true
    app_command_line = ""
  }
  app_settings = {
    "DOCKER_ENABLE_CI" = "true"
    "DOCKER_REGISTRY_SERVER_URL" = var.ACR_LOGIN_SERVER
    "FUNCTIONS_WORKER_RUNTIME" = "custom"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "FUNCTIONS_EXTENSION_VERSION" = "~4"
    "DOCKER_CUSTOM_IMAGE_NAME" = "mypythonapp:latest"
    "WEBSITES_PORT" = "5000"
    "APPINSIGHTS_INSTRUMENTATIONKEY"    = var.ACR_LOGIN_SERVER
    "APPINSIGHTS_PROFILER_ENABLED"      = "true"
    "APPINSIGHTS_SNAPSHOT_DEBUGGER_ENABLED" = "true"
  }
    identity {
    type = "SystemAssigned"
  }


}

resource "azurerm_service_plan" "appservplan" {
  name                = var.FUNCTION_APP_SERV_PLAN_NAME
  resource_group_name = var.RESOURCE_GROUP_NAME
  location            = var.LOCATION
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_role_assignment" "roleassign" {
  scope                = var.STORAGE_ACC_ID
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.appfunc.identity[0].principal_id
  depends_on = [
    azurerm_linux_function_app.appfunc
  ]
}