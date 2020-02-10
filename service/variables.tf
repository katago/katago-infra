# GCP variables

variable "region" {
  default     = "europe-west4"
  description = "Region of resources"
}

variable "bucket_name" {
  description = "Name of the google storage bucket"
}
