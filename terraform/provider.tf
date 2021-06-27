provider "oci" {
  tenancy_ocid         = var.TENANCY_OCID
  user_ocid            = var.USER_OCID
  fingerprint          = var.FINGERPRINT
  private_key          = var.PRIVATE_KEY
  private_key_password = var.PRIVATE_KEY_PASSWORD
  region               = var.REGION
}