module "project" {
  source = "./modules/project"

  billing_account = var.billing_account
  org_id          = var.org_id
}