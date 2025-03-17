variable "network_security_groups" {
  type = map(object({
    index                  = string
    location_key           = string
    security_rules = map(object({
      name                       = string
      access                     = string
      destination_address_prefix = optional(string)
      destination_address_prefixes = optional(list(string))
      destination_port_range     = optional(string)
      destination_port_ranges    = optional(list(string))
      direction                  = string
      priority                   = number
      protocol                   = string
      source_address_prefix      = optional(string)
      source_address_prefixes    = optional(list(string))
      source_port_range          = optional(string)
      source_port_ranges         = optional(list(string))
    }))
  }))
  description = "Map of Network Security Groups with their security rules."
}


variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
  }))
}

variable "naming" {
}
