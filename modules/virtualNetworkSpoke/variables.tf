variable "spokes" {
  type = map(object({
    index           = number
    address_space   = list(string)
    location        = string
    peerings        = map(object({
      name                             = string
      location                          = string
      allow_forwarded_traffic           = bool
      allow_gateway_transit             = bool
      allow_virtual_network_access      = bool
      use_remote_gateways               = bool
      create_reverse_peering            = bool
      reverse_name                      = string
      reverse_allow_forwarded_traffic   = bool
      reverse_allow_gateway_transit     = bool
      reverse_allow_virtual_network_access = bool
      reverse_use_remote_gateways       = bool
    }))
    subnets = map(object({
      index              = string
      address_prefixes  = list(string)
      location          = string
    }))
  }))
  description = "Configuration for each spoke, including its address space, peerings, and subnets."
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

# variable "remote_virtual_network" {
#   type = map(object({
#     virtual_networks = map(string)
#     hub_route_tables_user_subnets = map(string)
#   }))
# }
variable "remote_virtual_network_resource_id" {
}

variable "route_table_id" {
}