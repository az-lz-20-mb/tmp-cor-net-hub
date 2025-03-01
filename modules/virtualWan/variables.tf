variable "location" {
  description = "The location for resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "name" {
  description = "The name of the Virtual WAN."
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., dev, prod)."
  type        = string
  default     = "test"
}

variable "owner" {
  description = "Owner tag."
  type        = string
  default     = "team@example.com"
}

variable "con_vnet_ids" {
  description = "The name of the virtual network."
}

variable "vpn_encryption" {
  description = "Enable VPN encryption."
  type        = bool
  default     = true
}

variable "allow_b2b_traffic" {
  description = "Allow branch to branch traffic."
  type        = bool
  default     = true
}

variable "type" {
  description = "The type of the Virtual WAN."
  type        = string
  default     = "Standard"
}

variable "short_location" {
  description = "The short location for resources."
  type        = string
}

variable "create_resource_group" {
  description = "Create a new resource group."
  type        = bool
  default     = true
}

variable "internet_security_enabled" {
  description = "Enable internet security."
  type        = bool
  default     = true
}

variable "firewall_sku_tier" {
  description = "The firewall SKU tier."
  type        = string
  default     = "Standard"
}

variable "virtual_hubs" {
  description = "The virtual hubs."
  type        = list(object({
    name            = string
    location        = string
    resource_group  = string
    address_prefix  = string
    deploy_firewall = bool
    deploy_vpn_gateway = bool
  }))
}

variable "vnet_connection" {
  type = map(list(string))
  description = "Mapping of Virtual Hubs to their associated VNets"
}

