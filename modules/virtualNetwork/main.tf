module "vnet" {
  source              = "git::https://github.com/az-lz-20-mb/mod-avm-res-virtualnetwork.git"
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = var.vnet_name

  address_space = var.vnet_address_space

  encryption = {
    enabled = var.enable_encryption
    enforcement = "AllowUnencrypted"
  }

  subnets = {
    subnet1 = {
      name                            = "${module.vnet.name}-subnet-1"
      default_outbound_access_enabled = var.default_outbound_access_enabled
      address_prefixes                = var.subnet1_address_prefixes
    }
    subnet2 = {
      name                            = "${module.vnet.name}-subnet-2"
      address_prefixes                = var.subnet2_address_prefixes
      default_outbound_access_enabled = var.default_outbound_access_enabled
    }
  }
}

output "vnet_id" {
  value = module.vnet.resource_id
}
