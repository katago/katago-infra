# Create Subnet

resource "google_compute_subnetwork" "subnet" {
  name          = "${terraform.workspace}-subnet"
  ip_cidr_range = var.subnet_ip_cidr
  network       = var.vpc_name
  region        = var.region

  project = var.project

  secondary_ip_range {
    ip_cidr_range = var.subnet_pods_cidr
    range_name    = "pods"
  }

  secondary_ip_range {
    ip_cidr_range = var.subnet_services_cidr
    range_name    = "services"
  }
}