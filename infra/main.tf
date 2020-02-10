module "vpc" {
  source = "./modules/network/vpc"

  project = data.terraform_remote_state.project.outputs.project_id
}

module "subnet" {
  source      = "./modules/network/subnet"
  project     = data.terraform_remote_state.project.outputs.project_id
  region      = var.region
  vpc_name    = module.vpc.vpc_name
  subnet_cidr = var.subnet_cidr
}

module "firewall" {
  source        = "./modules/network/firewall"
  project       = data.terraform_remote_state.project.outputs.project_id
  vpc_name      = module.vpc.vpc_name
  ip_cidr_range = module.subnet.ip_cidr_range
}

module "cloudsql" {
  source                     = "./modules/cloudsql"
  project                    = data.terraform_remote_state.project.outputs.project_id
  region                     = var.region
  availability_type          = var.availability_type
  sql_instance_size          = var.sql_instance_size
  sql_disk_type              = var.sql_disk_type
  sql_disk_size              = var.sql_disk_size
  sql_require_ssl            = var.sql_require_ssl
  sql_master_zone            = var.sql_master_zone
  sql_connect_retry_interval = var.sql_connect_retry_interval
  sql_replica_zone           = var.sql_replica_zone
  sql_user                   = var.sql_user
  sql_pass                   = var.sql_pass
}

module "gke" {
  source                = "./modules/gke"
  project               = data.terraform_remote_state.project.outputs.project_id
  region                = var.region
  min_master_version    = var.min_master_version
  node_version          = var.node_version
  gke_num_nodes         = var.gke_num_nodes
  vpc_name              = module.vpc.vpc_name
  subnet_name           = module.subnet.subnet_name
  gke_node_machine_type = var.gke_node_machine_type
  gke_label             = var.gke_label
}