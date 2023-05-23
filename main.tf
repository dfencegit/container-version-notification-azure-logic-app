terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.90.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

# Create Resource Group
resource "azurerm_resource_group" "container_tag_notifications" {
  name = "container_tag_notifications"
  location = "uksouth"
}

resource "azurerm_storage_account" "lastcontainerversions" {
    name = "lastcontainerversions"
    resource_group_name = azurerm_resource_group.container_tag_notifications.name
    location = azurerm_resource_group.container_tag_notifications.location
    account_tier = "Standard"
    account_replication_type = "LRS"  
    account_kind = "StorageV2"
    allow_blob_public_access = true
    min_tls_version = "TLS1_2"
}

resource "azurerm_storage_table" "lastcontainerversiontable" {
    name                 = "lastcontainerversiontable"
    storage_account_name =  azurerm_storage_account.lastcontainerversions.name
}

resource "azurerm_logic_app_workflow" "check-latest-container-tags" {
  name                = "check-latest-container-tags"
  resource_group_name = azurerm_resource_group.container_tag_notifications.name
  location = azurerm_resource_group.container_tag_notifications.location  
}