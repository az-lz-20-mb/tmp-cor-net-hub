variable "hub_virtual_networks" {
  type = map(object({
    index            = string
    location          = string
    address_space   = list(string)
    routing_address_space = list(string)

    firewall = optional(object({
      subnet_address_prefix = string
      sku_name              = string
      sku_tier              = string
      firewall_policy = object({
        dns = object({
          proxy_enabled = bool
        })
      })
    }))

    subnets = map(object({
      index            = string
      address_prefixes = list(string)
      route_table      = optional(object({
        assign_generated_route_table = bool
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
}