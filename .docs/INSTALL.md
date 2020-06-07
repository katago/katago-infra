# Katago Infra installation Guide

## Prerequisites

- Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
- Install [Google Cloud SDK](https://cloud.google.com/sdk/)
- Install [kubectl](https://kubernetes.io/fr/docs/tasks/tools/install-kubectl/)

Then initialize `gcloud`:

```bash
gcloud init
```

## GCloud admin project

> The goal is is to create a "root" project and a service account.
> From that project, Terraform will be able to create the actual project and resources.

⚠ This guide implies that you have an organisation access to gcloud resources ⚠

### Create a GCloud project

Get your GCloud organisation

```bash
gcloud organizations list
```

and create a project `<PROJECT_ADMIN>` with the result `<ORG_ID>` of previous command

```bash
gcloud projects create <PROJECT_ADMIN> --organization <ORG_ID> --set-as-default
```

Then get your `BILLING_ACCOUNT_ID`:

```bash
gcloud beta billing accounts list
```

and activate billing using the result from above command

```bash
gcloud beta billing projects link <PROJECT_ADMIN> --billing-account <BILLING_ACCOUNT_ID>
```

### Create a service account for terraform

```bash
gcloud iam service-accounts create terraform
```

and download the credentials:

```bash
gcloud iam service-accounts keys create ./.credentials/terraform-credentials.json \
--iam-account terraform@<PROJECT_ADMIN>.iam.gserviceaccount.com
```

Change your environment so terrafrom knows how to pick up the credentials:

Windows(PS):

```powershell
$Env:GOOGLE_APPLICATION_CREDENTIALS="C:\Users\tycho\Documents\code\katago_infra\.credentials\terraform-credentials.json"
```

### Grant permissions for project

```bash
gcloud projects add-iam-policy-binding <PROJECT_ADMIN> --member serviceAccount:terraform@<PROJECT_ADMIN>.iam.gserviceaccount.com --role roles/viewer
gcloud projects add-iam-policy-binding <PROJECT_ADMIN> --member serviceAccount:terraform@<PROJECT_ADMIN>.iam.gserviceaccount.com --role roles/storage.admin
```

### Enable Apis

```bash
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable container.googleapis.com
```

### Grant permissions for organisation

```bash
gcloud organizations add-iam-policy-binding <ORG_ID> --member serviceAccount:terraform@<PROJECT_ADMIN>.iam.gserviceaccount.com --role roles/resourcemanager.projectCreator
```

## Terraform

Start by creating a project:

```bash
cd project
terraform init
terraform workspace new prod
terraform plan -out prod.tfplan
terrafom apply prod.tfplan
cd ..
```

Then setup the infrastructure:

```bash
cd infra
terraform init
terraform workspace new prod
terraform plan -out prod.tfplan
terrafom apply prod.tfplan
```
