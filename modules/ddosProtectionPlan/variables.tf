variable "ddos_protection_plans" {
  description = "Map of DDoS Protection Plans to be deployed"
  type = map(object({
    enable   = bool
    location = string
  }))
  default = {}
}

variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
  }))
}

variable "naming" {
}