locals {
  virtual_hub_key = "${var.name}-hub-key"
  firewall_key    = "fw-${var.name}-key"
  vpn_gateways_key = "${var.name}-vpn-gateway-key"
}

module "vwan_with_vhub" {
  source                         = "git::https://github.com/az-lz-20-mb/mod-avm-res-virtualwan.git"
  create_resource_group          = var.create_resource_group
  resource_group_name            = var.resource_group_name
  location                       = var.location
  virtual_wan_name               = var.name
  disable_vpn_encryption         = var.vpn_encryption
  allow_branch_to_branch_traffic = var.allow_b2b_traffic
  type                           = var.type
  virtual_wan_tags = {
    environment = var.environment
    owner       = var.owner
    location    = var.short_location
  }
  virtual_hubs = {
    (local.virtual_hub_key) = {
      name           = "${var.name}-hub"
      location       = var.location
      resource_group = var.resource_group_name
      address_prefix = var.address_prefix
      tags = {
        environment = var.environment
        owner       = var.owner
        location    = var.short_location
      }
    }
  }
  virtual_network_connections = {
      for_each                  = var.con_vnet_ids
      name                      = "${basename(each.value)}-connection"
      virtual_hub_key           = "vwan-lz20-hub-key"
      remote_virtual_network_id = each.value
      internet_security_enabled = true
  }
   firewalls = {
    (local.firewall_key) = {
      sku_name           = "AZFW_Hub"
      sku_tier           = var.firewall_sku_tier
      name               = "fw-${var.name}"
      virtual_hub_key    = local.virtual_hub_key
    }
  }
  routing_intents = {
    "${var.name}-routing-intent" = {
      name            = "private-routing-intent"
      virtual_hub_key = local.virtual_hub_key
      routing_policies = [{
        name                  = "${var.name}-routing-policy-private"
        destinations          = ["PrivateTraffic"]
        next_hop_firewall_key = local.firewall_key
      }]
    }
  }
    vpn_gateways = {
    (local.vpn_gateways_key) = {
      name            = "${var.name}-vpn-gateway"
      virtual_hub_key = local.virtual_hub_key
    }
  }
}
