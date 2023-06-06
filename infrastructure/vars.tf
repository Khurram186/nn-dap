# Define variables
variable "resource_group_name" {
  type    = string
  default = "nn-dap-resource-group"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "acr_name" {
  type    = string
  default = "nn-dap-acr"
}

variable "function_app_name" {
  type    = string
  default = "nn-dap-function-app-987654"
}
variable "function_app_service_plan_name" {
  type    = string
  default = "nn-dap-function-app-service-plan"
}

variable "docker_image" {
  type    = string
  default = "nn-dap-myapp"
}

variable "vnet_name" {
  type    = string
  default = "nn-dap-vnet"
}

variable "subnet_name" {
  type    = string
  default = "nn-dap-subnet"
}

variable "ple_subnet_name" {
  type    = string
  default = "ple-subnet"
}

variable "function_app_insights_name" {
  type    = string
  default = "nn-dap_function_app_insights"
}
variable "azurerm_container_registry_webhook_name" {
  type    = string
  default = "nn-dap-acr-webhook"
}