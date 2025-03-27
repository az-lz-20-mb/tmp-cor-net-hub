variable "ddos_protection_plans" {
  description = "Map of DDoS Protection Plans to be deployed"
  type = map(object({
    enable   = bool
    location = string
  }))
  default = {}
}