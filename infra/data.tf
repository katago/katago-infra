data "terraform_remote_state" "project_id" {
  backend   = "gcs"
  workspace = terraform.workspace

  config = {
    bucket = var.bucket_name
    prefix = "terraform-project"
  }
}