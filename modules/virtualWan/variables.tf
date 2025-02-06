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
  type        = list(string)
  
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

variable "address_prefix" {
  description = "The address prefix of the virtual hub."
  type        = string
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

variable "virtual_network_connections" {
  description = "Map of virtual network connections"
  type = map(object({
    virtual_hub_key           = string
    internet_security_enabled = bool
  }))
  default = {
    "default_connection" = {
      virtual_hub_key           = local.virtual_hub_key
      internet_security_enabled = var.default_internet_security_enabled
    }
  }
}