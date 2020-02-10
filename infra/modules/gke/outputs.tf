# GKE outputs

output "endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "Endpoint for accessing the master node"
}

output "auth" {
  value       = google_container_cluster.primary.master_auth
  description = "Endpoint for accessing the master node"
}
