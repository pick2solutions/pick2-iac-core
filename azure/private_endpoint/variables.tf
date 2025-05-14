variable "resource_id" {
  description = "ID of the target resource for the private endpoint."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet for the private endpoint."
  type        = string
}

variable "vnet_id" {
  description = "ID of the virtual network for DNS linking."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

variable "location" {
  description = "Azure location."
  type        = string
}

variable "subresources" {
  description = "List of subresources to create private endpoints for (e.g. blob, table)."
  type = list(object({
    name = string
  }))
}

variable "dns_zone_ids" {
  description = "Map of subresource name to DNS Zone ID."
  type        = map(string)
}

variable "enable_vnet_link" {
  description = "Whether to enable the virtual network link."
  type        = bool
  default     = true
}

variable "name_suffix" {
  description = "Suffix to add to the resource names."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resources."
  type        = map(string)
  default     = {}
}
