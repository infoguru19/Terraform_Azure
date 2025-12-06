resource "azurerm_resource_group" "demope" {
  name     = "demope-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "demope" {
  name                     = "demopeaccount1607456"
  resource_group_name      = azurerm_resource_group.demope.name
  location                 = azurerm_resource_group.demope.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = false
  allow_nested_items_to_be_public = false
}

resource "azurerm_virtual_network" "demope" {
  name                = "virtnetname"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.demope.location
  resource_group_name = azurerm_resource_group.demope.name
}

resource "azurerm_subnet" "demope" {
  name                 = "subnetname"
  resource_group_name  = azurerm_resource_group.demope.name
  virtual_network_name = azurerm_virtual_network.demope.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_private_endpoint" "demope" {
  name                = "demope-endpoint"
  location            = azurerm_resource_group.demope.location
  resource_group_name = azurerm_resource_group.demope.name
  subnet_id           = azurerm_subnet.demope.id

  private_service_connection {
    name                           = "demope-privateserviceconnection"
    private_connection_resource_id = azurerm_storage_account.demope.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "demope-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.demope.id]
  }
}

resource "azurerm_private_dns_zone" "demope" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.demope.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "demope" {
  name                  = "demope-link"
  resource_group_name   = azurerm_resource_group.demope.name
  private_dns_zone_name = azurerm_private_dns_zone.demope.name
  virtual_network_id    = azurerm_virtual_network.demope.id
}