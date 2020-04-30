data "oci_identity_availability_domains" "ads" {
  compartment_id = var.COMPARTMENT_OCID
}

data "oci_core_public_ip" "public_ip01" {
    ip_address = "132.145.118.149"
}

# output "ubuntu01" {
#   value = oci_core_instance.ubuntu01
# }

output "ubuntu02" {
  # value = oci_core_instance.ubuntu02[0]
  value = lookup(oci_core_instance.ubuntu02[0], "public_ip")
}