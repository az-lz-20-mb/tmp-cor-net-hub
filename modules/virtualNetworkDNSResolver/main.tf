module "private_resolver" {
  source = "Azure/avm-res-network-dnsresolver/azurerm"
  for_each                    = var.resolvers
  resource_group_name         = lookup(var.resource_group_name[each.value.location_key], "rg")
  name                        = "resolver"
  virtual_network_resource_id = lookup(var.remote_virtual_networks[each.key], "id")
  location                    = lookup(var.resource_group_name[each.value.location_key], "location")

  inbound_endpoints = {
    "inbound1" = {
      name        = "inbound1"
      subnet_name = lookup(var.remote_virtual_networks[each.key].subnets, "name")
    }
  }

  outbound_endpoints = {
    "outbound1" = {
      name        = "outbound1"
      subnet_name = lookup(var.remote_virtual_networks[each.key].subnets["subnet1"], "name")
      forwarding_ruleset = {
        for ruleset_key, ruleset in each.value.forwarding_ruleset : ruleset_key => {
          name  = ruleset.name
          rules = {
            for rule_key, rule in ruleset.rules : rule_key => {
              name                     = rule.name
              domain_name              = rule.domain_name
              state                    = rule.state
              destination_ip_addresses = rule.destination_ip_addresses
            }
          }
        }
      }
    }
  }
}