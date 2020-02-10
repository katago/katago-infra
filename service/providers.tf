provider "kubernetes" {
  host = data.terraform_remote_state.infra.outputs.gke_endpoint

  client_certificate     = base64decode(data.terraform_remote_state.infra.outputs.gke_auth.0.client_certificate)
  client_key             = base64decode(data.terraform_remote_state.infra.outputs.gke_auth.0.client_key)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.infra.outputs.gke_auth.0.cluster_ca_certificate)

  version = "~> 1.10"
}

provider "helm" {
  kubernetes {
    host = data.terraform_remote_state.infra.outputs.gke_endpoint

    client_certificate     = base64decode(data.terraform_remote_state.infra.outputs.gke_auth.0.client_certificate)
    client_key             = base64decode(data.terraform_remote_state.infra.outputs.gke_auth.0.client_key)
    cluster_ca_certificate = base64decode(data.terraform_remote_state.infra.outputs.gke_auth.0.cluster_ca_certificate)
  }

  version = "~> 1.0"
}
