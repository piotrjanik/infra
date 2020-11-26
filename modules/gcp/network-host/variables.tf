variable "project_id" {
  description = "GCP Project ID hosting Shared VPC"
  validation {
    condition     = can(regex("^piotr-", var.project_id))
    error_message = "Project ID needs to start with piotr-"
  }
}
variable "network_name" {
  description = "GCP Shared VPC Network name"
}

variable "subnets" {
  type = map(object({ cidr = string, private = bool, region = string, secondary = map(string) }))
}