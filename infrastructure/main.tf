# storage_account_name: nntfstate19107
# container_name: nntfstate
# access_key: 2PUcbqKTG8N/ubxKaOtcWNiVBKb2w8efVGWV0KzBFNofHIRLDVAcqD5X1uulWWe4ASPPw/gai/C++AStyyuuGA==
# backend configs to store terraform state file 
terraform {
  backend "azurerm" {
    resource_group_name  = "nntfstate"
    storage_account_name = "nntfstate19107"
    container_name       = "nntfstate"
    key                  = "terraform.tfstate"
  }
}

# module to create network
module "network" {
  source = "./modules/network"
  RESOURCE_GROUP_NAME = var.resource_group_name
  LOCATION            = var.location
  VNET_NAME           = var.vnet_name
  SUBNET_NAME         = var.subnet_name
  PLE_SUBNET_NAME     = var.ple_subnet_name
  
}

# module to create storage acc and acr
module "storage" {
  source = "./modules/storage"
  RESOURCE_GROUP_NAME = module.network.azurerm_resource_group_name
  LOCATION            = var.location
  SUBNET_ID           = module.network.azurerm_subnet_id
  depends_on          = [ module.network ]
}

# module to create function app and app service plan
module "function-app" {
  source                        = "./modules/function_app"
  FUNCTION_APP_NAME             = var.function_app_name
  FUNCTION_APP_SERV_PLAN_NAME   = var.function_app_service_plan_name
  RESOURCE_GROUP_NAME           = module.network.azurerm_resource_group_name
  LOCATION                      = var.location    
  VNET_NAME                     = module.network.azurerm_virtual_network_name
  SUBNET_NAME                   = module.network.azurerm_subnet_name
  STORAGE_ACC_NAME              = module.storage.azurerm_storage_account_name
  STORAGE_ACC_ACCESS_KEY        = module.storage.azurerm_storage_account_primary_access_key
  ACR_LOGIN_SERVER              = module.storage.azurerm_container_registry_login_server
  STORAGE_ACC_ID                = module.storage.azurerm_storage_account_id
  depends_on = [ module.network , module.storage ]
  
}

module "accessManagement" {
  source = "./modules/accessManagement"
  RESOURCE_GROUP_NAME = module.network.azurerm_resource_group_name
  LOCATION            = var.location
  PLE_SUBNET_ID       = module.network.azurerm_ple_subnet_id
  ACR_SERVER_ID       = module.storage.azurerm_container_registry_id
  STORAGE_ACCOUNT_ID  = module.storage.azurerm_storage_account_id

  depends_on          = [ module.storage ]

}

# module to create monitoring
module "monitoring" {
  source = "./modules/monitoring"
    RESOURCE_GROUP_NAME         = module.network.azurerm_resource_group_name
    LOCATION                    = var.location
    APP_INSIGHT_NAME            = var.function_app_insights_name
    depends_on          = [ module.network ]
  
}
