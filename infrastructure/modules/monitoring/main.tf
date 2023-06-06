variable "RESOURCE_GROUP_NAME" {}
variable "LOCATION" {}
variable "APP_INSIGHT_NAME" {}

resource "azurerm_application_insights" "appinsight" {
  name                = var.APP_INSIGHT_NAME
  location            = var.LOCATION
  resource_group_name = var.RESOURCE_GROUP_NAME
  application_type    = "web"
}