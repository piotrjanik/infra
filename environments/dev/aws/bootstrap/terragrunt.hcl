terraform {
  source = "../../../../modules/aws/account"
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
  organisation = include.root.locals.gcp.organisation
  name         = include.root.locals.projectName
  env          = include.env.locals.env
}