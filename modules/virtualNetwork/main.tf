module "vnet" {
  for_each = var.vnets

  source              = "git::https://github.com/az-lz-20-mb/mod-avm-res-virtualnetwork.git"
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "${var.name}-${each.key}"

  address_space = each.value.vnet_address_space

  encryption = {
    enabled     = each.value.enable_encryption
    enforcement = "AllowUnencrypted"
  }

  subnets = { for subnet_key, subnet_config in each.value.subnets : subnet_key => {
    name                            = "${var.subnet_name}-${subnet_key}"
    address_prefixes                = subnet_config.address_prefixes
    default_outbound_access_enabled = subnet_config.default_outbound_access_enabled
  }}
}

output "vnet_ids" {
  value = { for k, v in module.vnet : k => v.resource_id }
}
# output "subnet_ids" {
#   value = { for k, v in module.vnet : k => v.subnets.id }  
# }
