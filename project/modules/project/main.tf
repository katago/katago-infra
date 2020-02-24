resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.project_name[terraform.workspace]}-"
}

resource "google_project" "project" {
  name            = var.project_name[terraform.workspace]
  project_id      = random_id.id.hex
  billing_account = var.billing_account
  org_id          = var.org_id
}

locals {
  enabled_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "deploymentmanager.googleapis.com",
    "dns.googleapis.com",
    "logging.googleapis.com",
    "servicenetworking.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "pubsub.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "servicemanagement.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "storage-api.googleapis.com",
  ]
}

resource "google_project_service" "project" {
  for_each = toset(local.enabled_apis)
  project  = google_project.project.project_id
  service  = each.value

  disable_dependent_services = true
  disable_on_destroy         = true
}
