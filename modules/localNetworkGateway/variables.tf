variable "local_network_gateways" {
  description = "Map of local network gateways"
  type = map(object({
    gateway_address = string
    address_space   = list(string)
    bgp_settings    = any
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
