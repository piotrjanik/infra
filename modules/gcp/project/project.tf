locals {
  name = format("%s-%s", var.name, var.env)
}
module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 15.0"

  name              = local.name
  random_project_id = true
  project_id        = local.name
  org_id            = var.organisation
  billing_account   = var.billing_account

}