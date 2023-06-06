output "azurerm_resource_group_name" {
  value = azurerm_resource_group.rg.name
  description = "Deployed resource group app name"
}
output "azurerm_virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
  description = "Deployed virtual network name"
}
output "azurerm_subnet_name" {
  value = azurerm_subnet.sub-net.name
  description = "Deployed subnet name"
}
output "azurerm_subnet_id" {
  value = azurerm_subnet.sub-net.id
  description = "Deployed subnet name"
}
output "azurerm_ple_subnet_name" {
  value = azurerm_subnet.ple-sub-net.name
  description = "Deployed subnet name"
}
output "azurerm_ple_subnet_id" {
  value = azurerm_subnet.ple-sub-net.id
  description = "Deployed subnet name"
}