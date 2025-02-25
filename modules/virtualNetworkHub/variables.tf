variable "hub_virtual_networks" {
  type = map(object({
    index            = string
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
  type = map(string)
}

variable "firewall_name" {
  description = "The name of the firewall"
  type        = string
}

variable "firewall_policy_name" {
  description = "The name of the firewall policy"
  type        = string
}

variable "route_table_name" {
  description = "The name of the route table"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "hub_name" {
  description = "The name of the hub"
  type        = string
}
