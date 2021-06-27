data "oci_identity_availability_domains" "ads" {
  compartment_id = var.COMPARTMENT_OCID
}

data "oci_core_public_ip" "public_ip01" {
  ip_address = "132.145.118.149"
}