variable "region" {
  default     = "europe-west4"
  description = "Region of resources"
}

variable "bucket_name" {
  description = "Name of the google storage bucket"
}

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