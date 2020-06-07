provider "random" {}

resource "random_id" "master" {
  byte_length = 4
  prefix      = "katago-server-${terraform.workspace}-"
}

resource "google_compute_global_address" "private_ip" {
  provider = google-beta

  project = var.project

  name          = "db-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc
}

resource "google_service_networking_connection" "db_vpc_connection" {
  network                 = var.vpc
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip.name]
}


resource "google_sql_database_instance" "master" {
  depends_on = [google_service_networking_connection.db_vpc_connection]

  name             = "${random_id.master.hex}-lead"
  region           = var.region
  database_version = "POSTGRES_12"

  project = var.project

  settings {
    availability_type = var.availability_type[terraform.workspace]
    tier              = var.sql_instance_size
    disk_type         = var.sql_disk_type
    disk_size         = var.sql_disk_size
    disk_autoresize   = true

    ip_configuration {
      private_network = var.vpc
      require_ssl     = true
      ipv4_enabled    = false
    }

    location_preference {
      zone = "${var.region}-${var.sql_master_zone}"
    }

    backup_configuration {
      #      binary_log_enabled = true
      enabled    = true
      start_time = "00:00"
    }
  }
}

resource "google_sql_database_instance" "replica" {
  depends_on = [
    google_sql_database_instance.master,
  ]

  name             = "${random_id.master.hex}-replica-0"
  count            = terraform.workspace == "prod" ? 1 : 0
  region           = var.region
  database_version = "POSTGRES_11"

  project = var.project

  master_instance_name = google_sql_database_instance.master.name

  settings {
    tier            = var.sql_instance_size[terraform.workspace]
    disk_type       = var.sql_disk_type
    disk_size       = var.sql_disk_size
    disk_autoresize = true

    location_preference {
      zone = "${var.region}-${var.sql_replica_zone}"
    }
  }
}

resource "google_sql_user" "user" {
  depends_on = [
    google_sql_database_instance.master,
    google_sql_database_instance.replica,
  ]

  project = var.project

  instance = google_sql_database_instance.master.name
  name     = var.sql_user
  password = var.sql_pass
}
