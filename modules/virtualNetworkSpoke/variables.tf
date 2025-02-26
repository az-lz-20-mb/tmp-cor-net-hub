variable "spokes" {
  description = "Map of spoke virtual networks"
  type = map(object({
    name                = string
    location            = string
    address_space       = list(string)
    resource_group_name = string
    peering             = map(object({
      name                                 = string
      remote_virtual_network_resource_id   = string
      allow_forwarded_traffic              = bool
      allow_gateway_transit                = bool
      allow_virtual_network_access         = bool
      use_remote_gateways                  = bool
      create_reverse_peering               = bool
      reverse_name                         = string
      reverse_allow_forwarded_traffic      = bool
      reverse_allow_gateway_transit        = bool
      reverse_allow_virtual_network_access = bool
      reverse_use_remote_gateways          = bool
    }))
    subnets = map(object({
      name             = string
      address_prefixes = list(string)
      route_table      = object({
        id = string
      })
    }))
  }))
  default = {}
}

variable "naming" {
  description = "Naming convention object"
  type        = map(object({
    virtual_network = map(string)
    virtual_network_peering       = map(string)
    subnet          = map(string)
    route_table     = map(string)
    firewall        = map(string)
    firewall_policy = map(string)
  }))
}

variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
  }))
}

variable "remote_virtual_network" {
  type = map(object({
    id = string
  }))
}

variable "route_table" {
  type = map(object({
    id = string
  }))
}