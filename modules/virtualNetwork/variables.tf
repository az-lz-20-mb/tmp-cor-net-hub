variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location of the resource group."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the virtual network."
  type        = list(string)
}

variable "subnet1_address_prefixes" {
  description = "The address prefixes of the subnet."
  type        = list(string)
}

variable "subnet2_address_prefixes" {
  description = "The address prefixes of the subnet."
  type        = list(string)
}

variable "enable_encryption" {
  description = "Enable encryption."
  type        = bool
  default     = true
}

variable "default_outbound_access_enabled" {
  description = "Enable default outbound access."
  type        = bool
  default     = true
}