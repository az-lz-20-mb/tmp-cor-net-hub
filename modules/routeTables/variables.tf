variable "route_tables" {
  type = map(object({
    location_key            = string
    routes = map(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = optional(string)
    }))
    subnet_resource_ids = map(string)
  }))
  description = "Map of route tables with configurations"
}

variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
  }))
}

variable "naming" {
  description = "Naming convention object"
  type        = map(object({
    virtual_network = map(string)
    subnet          = map(string)
    route_table     = map(string)
    firewall        = map(string)
    firewall_policy = map(string)
  }))
}
