resource "azurerm_private_endpoint" "this" {
  for_each            = { for idx, sub in var.subresources : "${sub.name}" => sub }
  name               = "pe-${each.key}-${var.name_suffix}"
  location           = var.location
  resource_group_name = var.resource_group_name
  subnet_id          = var.subnet_id

  private_service_connection {
    name                           = "psc-${each.key}-${var.name_suffix}"
    private_connection_resource_id = var.resource_id
    subresource_names              = [each.value.name]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdz-${each.key}-${var.name_suffix}"
    private_dns_zone_ids = [lookup(var.dns_zone_ids, each.value.name)]
  }

  tags = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each            = var.enable_vnet_link ? var.dns_zone_ids : {}
  name                = "vnet-link-${each.key}-${var.name_suffix}"
  resource_group_name = var.resource_group_name
  private_dns_zone_name = element(split("/", each.value), length(split("/", each.value)) - 1)
  virtual_network_id  = var.vnet_id
  registration_enabled = false
}
