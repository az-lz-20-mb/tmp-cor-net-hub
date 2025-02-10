locals {
  virtual_hub_keys = { for hub in var.virtual_hubs : hub.name => "${hub.name}-hub-key" }
  firewall_keys    = { for hub in var.virtual_hubs : hub.name => "fw-${hub.name}-key" if hub.deploy_firewall }
  vpn_gateway_keys = { for hub in var.virtual_hubs : hub.name => "${hub.name}-vpn-gateway-key" if hub.deploy_vpn_gateway }
  vnet_keys        = { for vnet in var.con_vnet_ids : vnet => vnet }
   # Dynamically Mapping VNETs to Hubs
  vnet_connections_tmp = toset(flatten([
    for hub_name, vnets in var.vnet_connection : [
      for vnet in vnets : {
        name                            = "vnet-conn-${hub_name}-${vnet.name}"
        virtual_hub_key                 = lookup(local.virtual_hub_keys, hub_name, null)
        remote_virtual_network_id       = lookup(local.vnet_keys, vnet.resource_id, null)
        internet_security_enabled       = var.internet_security_enabled
      }
    ]]))

  vnet_connections = {for vnet_conn in local.vnet_connections_tmp : vnet_conn.name => vnet_conn }
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

  # Dynamic Virtual Hubs with virtual_hub_key
  virtual_hubs = {
    for hub in var.virtual_hubs : local.virtual_hub_keys[hub.name] => {
      name           = hub.name
      location       = hub.location
      resource_group = hub.resource_group
      address_prefix = hub.address_prefix
    }
  }
 # Dynamically Mapping VNETs to Hubs
  virtual_network_connections    = local.vnet_connections

  # Dynamic Firewalls using virtual_hub_key
  firewalls = {
    for hub in var.virtual_hubs : local.firewall_keys[hub.name] => {
      sku_name        = "AZFW_Hub"
      sku_tier        = var.firewall_sku_tier
      name            = "fw-${hub.name}"
      virtual_hub_key = local.virtual_hub_keys[hub.name]
    } if hub.deploy_firewall
  }

  # Routing Intent (Only for hubs with firewalls)
  routing_intents = {
    for hub in var.virtual_hubs : "${hub.name}-routing-intent" => {
      name            = "private-routing-intent"
      virtual_hub_key = local.virtual_hub_keys[hub.name]
      routing_policies = [{
        name                  = "${hub.name}-routing-policy-private"
        destinations          = ["PrivateTraffic"]
        next_hop_firewall_key = local.firewall_keys[hub.name]
      }]
    } if hub.deploy_firewall
  }

  # Dynamic VPN Gateways using virtual_hub_key
  vpn_gateways = {
    for hub in var.virtual_hubs : local.vpn_gateway_keys[hub.name] => {
      name            = "${hub.name}-vpn-gateway"
      virtual_hub_key = local.virtual_hub_keys[hub.name]
    } if hub.deploy_vpn_gateway
  }
}
