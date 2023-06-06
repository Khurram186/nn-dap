# Output the function app URL
output "function_app_url" {
  value = "https://${azurerm_linux_function_app.appfunc.default_hostname}"
}