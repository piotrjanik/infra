generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project     = "piotr-main"
  region      = "us-central1"
}

provider "aws" {
  region = "eu-west-1"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "gcs" {
    prefix      = "${path_relative_to_include()}"
    bucket      = "piotr-terraform-state"
  }
}
EOF
}

locals {
  projectName = "piotr-test"
  aws = {
    organisation = "r-s4l2"
  }
  gcp = {
    organisation    = "461296027236"
    billing_account = "01B60A-CF941F-EE72B4"
    region          = "europe-west1"
    network_name    = "test"
    subnets = {
      "piotr-test-main" = {
        cidr      = "10.0.0.0/16"
        private   = true
        region    = "europe-west1"
        secondary = {}
      }
      "piotr-test-dev" = {
        cidr    = "10.10.0.0/16"
        private = true
        region  = "europe-west1"
        secondary = {
          "pods"     = "10.16.0.0/16"
          "services" = "10.18.0.0/16"
        }
      }
    }
  }
}