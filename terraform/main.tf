terraform {
  backend "remote" {
    organization = "ymmmtym"

    workspaces {
      name = "terraform-cloud-oci"
    }
  }
  required_providers {
    rke = {
      source  = "rancher/rke"
      version = "1.2.3"
    }
  }
}