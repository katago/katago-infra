provider "google" {
  version = "3.24.0"
  region  = var.region
}

provider "google-beta" {
  version = "3.24.0"
  region  = var.region
}

provider "random" {
  version = "~> 2.2"
}
