resource "azurerm_storage_account" "example" {
 
  name                     = "tiyaranjan1607"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment
    lob = local.common_tags.lob
    Stage = local.common_tags.stage
  }
}