terraform {
  backend "remote" {
    organization = "ymmmtym"

    workspaces {
      name = "terraform-cloud-oci"
    }
  }
}