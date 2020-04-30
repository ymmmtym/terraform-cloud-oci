variable "TENANCY_OCID" {}
variable "USER_OCID" {}
variable "FINGERPRINT" {}
variable "PRIVATE_KEY" {}
variable "PRIVATE_KEY_PASSWORD" {}
variable "REGION" {
  default = "ap-tokyo-1"
}
variable "COMPARTMENT_OCID" {
  default = "${var.TENANCY_OCID}"
}

provider "oci" {
  tenancy_ocid = var.TENANCY_OCID
  user_ocid = var.USER_OCID
  fingerprint = var.FINGERPRINT
  private_key = var.PRIVATE_KEY
  private_key_password = var.PRIVATE_KEY_PASSWORD
  region = var.REGION
}