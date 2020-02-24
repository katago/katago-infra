variable "region" {
  description = "Region of resources"
}

variable "vpc_name" {
  description = "Netwrok name"
}

variable "subnet_ip_cidr" {
  type        = string
  description = "Subnet range"
}

variable "subnet_pods_cidr" {
  type        = string
  description = "Subnet range"
}

variable "subnet_services_cidr" {
  type        = string
  description = "Subnet range"
}

variable "project" {
  description = "Project id"
}