variable "TENANCY_OCID" {}
variable "USER_OCID" {}
variable "FINGERPRINT" {}
variable "PRIVATE_KEY" {}

provider "oci" {
  tenancy_ocid = var.TENANCY_OCID
  user_ocid = var.USER_OCID
  fingerprint = var.FINGERPRINT
  private_key_path = var.PRIVATE_KEY
  region = "ap-tokyo-1"
}
