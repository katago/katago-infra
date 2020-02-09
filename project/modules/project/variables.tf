variable "project_name" {
  default = {
    prod = "katago-server-prod"
    dev  = "katago-server-dev"
  }

  description = "The NAME of the Google Cloud project"
}

variable "billing_account" {
  description = "Billing account STRING."
}

variable "org_id" {
  description = "Organisation account NR."
}