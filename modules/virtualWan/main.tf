locals {
  virtual_hub_key = "${var.name}-hub-key"
  firewall_key    = "fw-${var.name}-key"
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
    vnet1 = {
      name                      = "vnet1-connection"
      virtual_hub_key           = local.virtual_hub_key
      remote_virtual_network_id = var.con_vnet_1_id
      internet_security_enabled = var.internet_security_enabled
    }
    vnet2 = {
      name                      = "vnet2-connection"
      virtual_hub_key           = local.virtual_hub_key
      remote_virtual_network_id = var.con_vnet_2_id
      internet_security_enabled = var.internet_security_enabled
    }
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
