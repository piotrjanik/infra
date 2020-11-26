terraform {
  source = "../../../../modules/gcp/network-host"
}


include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

dependency "bootstrap" {
  config_path = "../bootstrap"
}

inputs = {
  network_name = include.root.locals.gcp.network_name
  project_id   = dependency.bootstrap.outputs.project_id
  subnets      = include.root.locals.gcp.subnets
}