output "private_endpoint_ids" {
  value = { for k, v in azurerm_private_endpoint.this : k => v.id }
}

output "dns_zone_vnet_link_ids" {
  value = var.enable_vnet_link ? { for k, v in azurerm_private_dns_zone_virtual_network_link.this : k => v.id } : {}
}