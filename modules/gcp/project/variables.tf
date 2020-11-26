variable "name" {
  validation {
    condition     = can(regex("^piotr-", var.name))
    error_message = "Project ID needs to start with piotr-"
  }
}
variable "organisation" {}
variable "billing_account" {}
variable "env" {}
