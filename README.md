# terraform-cloud-oci

[![Terraform](https://github.com/ymmmtym/terraform-cloud-oci/actions/workflows/terraform.yml/badge.svg)](https://github.com/ymmmtym/terraform-cloud-oci/actions/workflows/terraform.yml) [![Codacy Badge](https://api.codacy.com/project/badge/Grade/8001200a311a4087a74660c085a11989)](https://www.codacy.com/manual/ymmmtym/terraform-cloud-oci?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ymmmtym/terraform-cloud-oci&amp;utm_campaign=Badge_Grade)

## Usage

### Prodction

1. Create branch from master.
2. Put tf files.
3. Create pull-request to master
4. Terraform Cloud run "terraform plan" (dry-run)
5. Merge pull-request
6. Terraform Cloud run "terraform apply" (deploy)

### Local

1. Get "terraform.tfvars" and "terraform.tfstate" from Terraform Cloud and Put files
2. Exec following command

```bash
docker run -it -v $PWD:/app -w /app hashicorp/terraform:0.12.24 init
docker run -it -v $PWD:/app -w /app hashicorp/terraform:0.12.24 plan \
  -var "PRIVATE_KEY=$(cat oci.pem)" \
  -var "SSH_PUBLIC_KEY=$(cat oci.pem.pub)"
docker run -it -v $PWD:/app -w /app hashicorp/terraform:0.12.24 apply \
  -var "PRIVATE_KEY=$(cat oci.pem)" \
  -var "SSH_PUBLIC_KEY=$(cat oci.pem.pub)"
```
