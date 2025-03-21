locals {
    tenant = var.tenant

    naming_purpose = {
        vhub   = "hub"
        vspoke = "spoke"
    }

    custom_naming = {
        rg_hub_base    = "hub-base"
        rg_spoke_base  = "spoke-base"
        nsg_rule       = "nsg-hub"
        peering        = "peer"
    }
}

module "naming" {
  for_each = var.index_map
  source   = "git::https://github.com/az-lz-20-mb/mod-tf-arm-naming.git"
  suffix   = [each.key, local.tenant] 
}

output "hub_resource_suffix" {
    value = local.naming_purpose.vhub
}

output "spoke_resource_suffix" {
    value = local.naming_purpose.vspoke
}

output "lz_caf_names" {
  value = module.naming
}

output "lz_custom_names" {
  value = {
    for key, value in var.index_map : key => {
      hub_base_resource_group_name          = "${module.naming[key].resource_group.name}-${local.custom_naming.rg_hub_base}"
      spoke_base_resource_group_name        = "${module.naming[key].resource_group.name}-${local.custom_naming.rg_spoke_base}"
      network_security_group_rule_name      = local.custom_naming.nsg_rule  
      peering_name                          = local.custom_naming.peering   
      dns_resolver_name                     = "dpr-${key}-${local.tenant}"   
      dns_in_endpoint_name                  = "dprie-${key}-${local.tenant}" 
      dns_out_endpoint_name                 = "dproe-${key}-${local.tenant}" 
    }
  }
}

output "lz_caf_naming" {
  value = {
    for key, value in var.index_map : key => {
        hub_resource = "${module.naming[key][resource].name}-${local.custom_naming.rg_hub_base}"
        spoke_resource = "${module.naming[key][resource].name}-${local.custom_naming.rg_spoke_base}"
    }
  }
}
