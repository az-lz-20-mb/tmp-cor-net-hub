variable "virtual_network_gateways" {
  type = map(object({
    index                     = string
    location_key              = string
    sku                       = string
    type                      = string
    subnet_address_prefix     = optional(string)
    subnet_creation_enabled   = optional(bool, false)
    vpn_active_active_enabled = optional(bool, false)
    vpn_bgp_enabled           = optional(bool, false)

    ip_configurations = optional(map(object({
      name            = string
      apipa_addresses = optional(list(string))
      public_ip       = optional(object({
        creation_enabled = bool
        id               = optional(string)
      }))
    })), {})

    local_network_gateways = optional(map(object({
      name                = string
      resource_group_name = string
      gateway_address     = string
      address_space       = list(string)
      connection          = object({
        type       = string
        shared_key = string
      })
    })), {})
  }))
  description = "Map of Virtual Network Gateways with optional IP configurations and local network gateways."
}

variable "naming" {
}

variable "remote_virtual_networks" {
}
