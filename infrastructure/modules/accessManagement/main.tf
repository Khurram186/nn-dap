### INPUT VARs ###
variable "RESOURCE_GROUP_NAME" {}
variable "LOCATION" {}
variable "PLE_SUBNET_ID" {}
variable "ACR_SERVER_ID" {}
variable "STORAGE_ACCOUNT_ID" {}

# Creates azure container registry private endpoint
resource "azurerm_private_endpoint" "acr-private-endpoint" {
  name                = "acr-pe"
  resource_group_name = var.RESOURCE_GROUP_NAME
  location            = var.LOCATION
  subnet_id           = var.PLE_SUBNET_ID

  private_service_connection {
    name                           = "acr-pe"
    is_manual_connection           = false
    private_connection_resource_id =  var.ACR_SERVER_ID
    subresource_names              = ["registry"]
  }
}

# Create storage account private endpoint
resource "azurerm_private_endpoint" "storage-account-endpoint" {
  name                = "storage-pe"
  resource_group_name = var.RESOURCE_GROUP_NAME
  location            = var.LOCATION
  subnet_id           = var.PLE_SUBNET_ID

  private_service_connection {
    name                           = "storage-pe"
    is_manual_connection           = false
    private_connection_resource_id = var.STORAGE_ACCOUNT_ID
    subresource_names              = ["blob"]
  }
}