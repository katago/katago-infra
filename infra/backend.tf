terraform {
  backend "gcs" {
    bucket = "katago-tf"
    // TODO rename to terraform infra
    prefix = "terraform"
  }
}