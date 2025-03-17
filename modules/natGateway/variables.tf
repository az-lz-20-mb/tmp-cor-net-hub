variable "nat_gateways" {
  type = map(object({
    location_key             = string
    index                    = string    

    public_ips = optional(map(object({
      name = string
      sku  = optional(string, "Standard")
    })))

    subnet_associations = optional(map(object({
      resource_id = string
    })))
  }))
  description = "Map of NAT Gateways with associated public IPs and subnet associations."
}

variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
  }))
}

variable "naming" {
}
