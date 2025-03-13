variable "resolvers" {
  description = "Map of resolvers"
  type = map(object({
    index        = string
    location_key   =    string
    forwarding_ruleset = map(object({
      name  = string
      rules = map(object({
        name                     = string
        domain_name              = string
        state                    = string
        destination_ip_addresses = list(string)
      }))
    }))
  }))
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

variable "remote_virtual_networks" {
  description = "Map of remote virtual networks"
  type        = map(object({
    id      = string
    subnets = map(object({
      name = string
    }))
  }))
}

variable "remote_virtual_subnets " {
}