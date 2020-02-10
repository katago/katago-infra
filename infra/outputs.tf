# remote state output
output "data_out" {
  value = data.terraform_remote_state.project.outputs.project_id
}

# network VPC output
output "vpc_name" {
  value       = module.vpc.vpc_name
  description = "The unique name of the network"
}

# subnet cidr ip range
output "ip_cidr_range" {
  value       = module.subnet.ip_cidr_range
  description = "Export created CICDR range"
}

# Cloud SQL postgresql outputs
output "master_instance_sql_ipv4" {
  value       = module.cloudsql.master_instance_sql_ipv4
  description = "The IPv4 address assigned for master"
}

# GKE outputs
output "gke_endpoint" {
  value       = module.gke.endpoint
  description = "Endpoint for accessing the master node"
}

output "gke_auth" {
  value       = module.gke.auth
  description = "Auth for accessing the master node"
}


