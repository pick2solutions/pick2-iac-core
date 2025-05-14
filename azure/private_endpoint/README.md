# Azure Private Endpoint Module

## Description

This module provisions Azure Private Endpoints for supported services (Storage, CosmosDB, PostgreSQL Flexible Server, SQL) with DNS integration.

## Inputs

Refer to `variables.tf` for a complete list of inputs.

## Outputs

- `private_endpoint_ids`: Map of private endpoint names to their resource IDs
- `dns_zone_vnet_link_ids`: Map of DNS zone names to their virtual network link IDs

## Example Usage

```hcl
module "private_endpoint" {
  source = "./modules/azure-private-endpoint"

  resource_id          = azurerm_storage_account.example.id
  subnet_id            = azurerm_subnet.example.id
  vnet_id              = azurerm_virtual_network.example.id
  resource_group_name  = var.rg
  location             = var.location
  name_suffix          = "example"

  subresources = [
    { name = "blob" },
    { name = "table" }
  ]

  dns_zone_ids = {
    blob  = azurerm_private_dns_zone.blob.id,
    table = azurerm_private_dns_zone.table.id
  }

  tags = {
    environment = "dev"
  }
}
```