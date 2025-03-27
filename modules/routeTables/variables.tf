variable "route_tables" {
  type = map(object({
    location_key            = string
    index                  = string
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
}
