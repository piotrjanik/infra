locals {
  name  = format("piotr-%s-%s", var.name, var.env)
  email = format("aws-%s@nautilia.pl", local.name)
}

resource "aws_organizations_account" "account" {
  name      = local.name
  email     = local.email
  parent_id = var.organisation
}