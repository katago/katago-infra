
variable "region" {
  description = "Region of resources"
}

variable "project" {
  description = "Project id"
}

variable "min_master_version" {
  description = "Number of nodes in each GKE cluster zone"
}

variable "node_version" {
  description = "Number of nodes in each GKE cluster zone"
}

variable "gke_num_nodes" {
  type        = map(number)
  description = "Number of nodes in each GKE cluster zone"
}

variable "vpc_name" {
  description = "vpc name"
}
variable "subnet_name" {
  description = "subnet name"
}

variable "gke_master_user" {
  description = "Username to authenticate with the k8s master"
}

variable "gke_master_pass" {
  description = "Username to authenticate with the k8s master"
}

variable "gke_node_machine_type" {
  description = "Machine type of GKE nodes"
}

# k8s variables
variable gke_label {
  type        = map(string)
  description = "label"
}