### INPUT VARs ###
variable "RESOURCE_GROUP_NAME" {}
variable "LOCATION" {}
variable "SUBNET_ID" {}

# Create the storage account
resource "azurerm_storage_account" "storageacc" {
  name                     = "nndapstorage${random_integer.example.result}"
  resource_group_name      = var.RESOURCE_GROUP_NAME
  location                 = var.LOCATION
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


# Create the Azure Container Registry
resource "azurerm_container_registry" "acr" {
    name                     = "nndapacr${random_integer.example.result}"
    location                 = var.LOCATION
    resource_group_name      = var.RESOURCE_GROUP_NAME
    sku                      = "Premium"
    admin_enabled            = true # to set false
    identity {
    type = "SystemAssigned"
  }
}

# Generate a random integer to ensure unique names
resource "random_integer" "example" {
  min = 10000
  max = 99999
}

# # Create the webhook for the Azure Container Registry
# resource "azurerm_container_registry_webhook" "example" {
#   name                = var.azurerm_container_registry_webhook_name
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   registry_name       = azurerm_container_registry.acr.name
#   service_uri         = azurerm_linux_function_app.appfunc.default_hostname
#   actions             = ["push"]
# }