output "azurerm_storage_account_name" {
  value = azurerm_storage_account.storageacc.name
  description = "Deployed storage account name"
}
output "azurerm_storage_account_primary_access_key" {
  value = azurerm_storage_account.storageacc.primary_access_key
  description = "Deployed acr primary access key"
}

output "azurerm_storage_account_id" {
  value = azurerm_storage_account.storageacc.id
  description = "Deployed acr primary access key"
}
output "azurerm_container_registry_name" {
  value = azurerm_container_registry.acr.name
  description = "Deployed acr name"
}
output "azurerm_container_registry_login_server" {
  value = azurerm_container_registry.acr.login_server
  description = "Deployed acr login server"
}

output "azurerm_container_registry_id" {
  value = azurerm_container_registry.acr.id
  description = "Deployed acr id"
}
