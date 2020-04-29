variable "TENANCY_OCID" {}
variable "USER_OCID" {}
variable "FINGERPRINT" {}
variable "PRIVATE_KEY" {}
variable "PRIVATE_KEY_PASSWORD" {}
variable "REGION" {
  default = "ap-tokyo-1"
}

provider "oci" {
  tenancy_ocid = var.TENANCY_OCID
  user_ocid = var.USER_OCID
  fingerprint = var.FINGERPRINT
  private_key = var.PRIVATE_KEY
  private_key_password = var.PRIVATE_KEY_PASSWORD
  region = var.REGION
}

# data "oci_identity_availability_domains" "ADs" {
#   compartment_id = var.TENANCY_OCID
# }

# output "ADprint" {
#   value = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
# }