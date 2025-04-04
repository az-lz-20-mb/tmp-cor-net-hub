locals {
    tenant = var.tenant

    naming_purpose = {
        hub   = "hub"
        spoke = "spoke"
    }

    custom_naming = {
        rg_base        = "base"
        nsg_rule       = "nsg"
        peering        = "peer"
        pdns_resolver = "dnspr"
        pdns_in_endpoint = "dnsie"
        pdns_out_endpoint = "dnsoe"
        policy = "firewall-policy"
    }
}

module "naming" {
  for_each = var.index_map
  source   = "git::https://github.com/az-lz-20-mb/mod-tf-arm-naming.git"
  suffix   = [each.key, local.tenant] 
}

output "raw_module" {
  value = module.naming
}

output "lz_custom_names" {
  value = {
    for key, value in var.index_map : key => {
      hub_base_resource_group_name          = "${module.naming[key].resource_group.name}-${local.naming_purpose.hub}-${local.custom_naming.rg_base}"
      spoke_base_resource_group_name        = "${module.naming[key].resource_group.name}-${local.naming_purpose.spoke}-${local.custom_naming.rg_base}"
      hub_network_security_group_name       = "${module.naming[key].network_security_group.name}-${local.naming_purpose.hub}"
      spoke_network_security_group_name     = "${module.naming[key].network_security_group.name}-${local.naming_purpose.spoke}"
      network_security_group_rule_name      = local.custom_naming.nsg_rule
      hub_route_table_name                  = "${module.naming[key].route_table.name}-${local.naming_purpose.hub}" 
      spoke_route_table_name                = "${module.naming[key].route_table.name}-${local.naming_purpose.spoke}"
      dns_resolver_name                     = "${local.custom_naming.pdns_resolver}-${key}-${local.tenant}"   
      dns_in_endpoint_name                  = "${local.custom_naming.pdns_in_endpoint}-${key}-${local.tenant}" 
      dns_out_endpoint_name                 = "${local.custom_naming.pdns_out_endpoint}-${key}-${local.tenant}" 
      virtual_network_gateway_name          = module.naming[key].virtual_network_gateway.name
      virtual_network_hub_name              = "${module.naming[key].virtual_network.name}-${local.naming_purpose.hub}" 
      hub_firewall_name                     = "${module.naming[key].firewall.name}-${local.naming_purpose.hub}" 
      hub_firewall_policy_name              = "${module.naming[key].firewall_policy.name}-${local.naming_purpose.hub}" // add the tier of firewall 
      hub_subnet_name                       = "${module.naming[key].subnet.name}-${local.naming_purpose.hub}" //add service name from key 
      virtual_network_spoke_name            = "${module.naming[key].virtual_network.name}-${local.naming_purpose.spoke}"
      peering_name                          = local.custom_naming.peering
      spoke_subnet_name                     = module.naming[key].subnet.name //add subsciption name and service name from key
      local_network_gateway_name            = module.naming[key].local_network_gateway.name //for local network gateway
      fwp_user_assigned_identity_name       = "${module.naming[key].user_assigned_identity.name}-${local.naming_purpose.hub}-${local.custom_naming.policy}"
      ddos_protection_plan_name             = module.naming[key].network_ddos_protection_plan.name
    }
  }
}

