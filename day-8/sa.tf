resource "azurerm_resource_group" "demo" {
  name     = "demo-resources"
  location = "North Europe"
}

resource "azurerm_storage_account" "demo" {
 
  name                     = "raviranjan1607"
  resource_group_name      = azurerm_resource_group.demo.name
  location                 = azurerm_resource_group.demo.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "prd"
  }
}