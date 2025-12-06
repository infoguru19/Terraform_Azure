
resource "azurerm_resource_group" "boot-diag" {
  name     = var.resource_group_name
  location = "North Europe"
}

resource "azurerm_storage_account" "boot-diag" {
 
  name                     = "${var.storage_account}1607"
  resource_group_name      = azurerm_resource_group.boot-diag.name
  location                 = azurerm_resource_group.boot-diag.location# implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "prd"
  }
}