resource "azurerm_private_endpoint" "demope" {
  name                = "demope-endpoint"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.internal.id

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
  depends_on = [ azurerm_storage_account.demope ]
}

resource "azurerm_private_dns_zone" "demope" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "demope" {
  name                  = "demope-link"
  resource_group_name   = azurerm_resource_group.example.name
  private_dns_zone_name = azurerm_private_dns_zone.demope.name
  virtual_network_id    = azurerm_virtual_network.main.id
}