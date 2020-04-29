variable "compartment_ocid" {
  default = "xxxxx"
}

data "oci_identity_availability_domains" "ADs" {
  provider = "oci.ap-tokyo-1"
  compartment_id = "var.TENANCY_OCID"
}