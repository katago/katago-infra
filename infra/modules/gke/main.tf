resource "google_container_cluster" "primary" {
  name     = "katago-server-${terraform.workspace}-cluster"
  location = var.region
  project  = var.project

  min_master_version = var.min_master_version

  initial_node_count       = var.gke_num_nodes[terraform.workspace]
  remove_default_node_pool = true

  network    = var.vpc_name
  subnetwork = var.subnet_name

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }


  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  master_auth {
    username = ""
    password = ""
  }
}


resource "google_container_node_pool" "primary_preemptible_nodes" {
  name     = "katago-server-${terraform.workspace}-node-pool"
  location = var.region
  project  = var.project


  version = var.node_version

  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible = true

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.gke_label[terraform.workspace]
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }

    disk_size_gb = 10
    machine_type = var.gke_node_machine_type
    tags         = ["gke-node"]
  }
}