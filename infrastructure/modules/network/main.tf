### INPUT VARs ###
variable "RESOURCE_GROUP_NAME" {}
variable "LOCATION" {}
variable "VNET_NAME" {}
variable "SUBNET_NAME" {}
variable "PLE_SUBNET_NAME" {}


# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = var.RESOURCE_GROUP_NAME
  location = var.LOCATION
}

# Create the virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = var.VNET_NAME
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [ azurerm_resource_group.rg ]
}

# Create the subnet
resource "azurerm_subnet" "sub-net" {
  name                 = var.SUBNET_NAME
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  private_endpoint_network_policies_enabled = true

  depends_on = [ azurerm_virtual_network.vnet ]
}

# Create the subnet
resource "azurerm_subnet" "ple-sub-net" {
  name                 = var.PLE_SUBNET_NAME
  address_prefixes     = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  private_endpoint_network_policies_enabled = true

  depends_on = [ azurerm_virtual_network.vnet ]
}
# Create the private DNS zone
resource "azurerm_private_dns_zone" "example" {
  name                = "nn-privatednszone.local"
  resource_group_name = azurerm_resource_group.rg.name
}
# link private DNS zone with virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                      = "nn-privatednszone-link"
  resource_group_name       = azurerm_resource_group.rg.name
  private_dns_zone_name     = azurerm_private_dns_zone.example.name
  virtual_network_id        = azurerm_virtual_network.vnet.id
  registration_enabled      = true
}