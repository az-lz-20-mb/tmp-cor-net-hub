// variables.tf
variable "firewall_policies" {
  type = map(object({
    location                        = string
    resource_group_name             = string
    proxy_enabled                   = bool
    tls_inspecion_name              = string
    firewall_policy_intrusion_detection = object({
      mode                          = string
      private_ranges                = list(string)
      signature_overrides           = list(object({
        id    = string
        state = string
      }))
      traffic_bypass                = list(object({
        description           = optional(string)
        destination_addresses = optional(set(string), [])
        destination_ip_groups = optional(set(string), [])
        destination_ports     = optional(set(string), [])
        name                  = string
        protocol              = string
        source_addresses      = optional(set(string), [])
        source_ip_groups      = optional(set(string), [])
      }))
    })
  }))
  description = "Map of firewall policies with configurations"
  default = {}
}

variable "resource_group_name" {
  type = map(object({
    location = string
    rg       = string
  }))
  description = "Map of resource group names and locations"
}