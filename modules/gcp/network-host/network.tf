locals {
  subnets = [
    for k, s in var.subnets :
    { subnet_name : k, subnet_ip : s.cidr, subnet_private_access : tostring(s.private), subnet_region : s.region }
  ]

  secondary_ranges_map = {
    for k, s in var.subnets : k => [for z, c in s.secondary : { range_name = format("%s-%s", k, z), ip_cidr_range = c }]
  }
}
module "vpc" {
  source          = "terraform-google-modules/network/google"
  version         = "~> 9.1"
  project_id      = var.project_id
  network_name    = var.network_name
  shared_vpc_host = true

  subnets          = local.subnets
  secondary_ranges = local.secondary_ranges_map
  routes           = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-inet"
      next_hop_internet = "true"
    }
  ]
}