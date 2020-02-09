variable "region" {
  description = "Region of resources"
}

variable "vpc_name" {
  description = "Netwrok name"
}

variable "subnet_cidr" {
  type        = map(string)
  description = "Subnet range"
}

variable "project" {
  description = "Project id"
}