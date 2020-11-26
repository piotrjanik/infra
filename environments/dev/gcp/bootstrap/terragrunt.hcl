terraform {
  source = "../../../../modules/gcp/project"
}


include "env" {
  path   = find_in_parent_folders("env.hcl")
  expose = true
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  organisation    = include.root.locals.gcp.organisation
  billing_account = include.root.locals.gcp.billing_account
  name            = include.root.locals.projectName
  env             = include.env.locals.env
}