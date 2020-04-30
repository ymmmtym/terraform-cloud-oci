# data "oci_identity_availability_domains" "ADs" {
#   compartment_id = var.COMPARTMENT_OCID
# }

# output "ADprint" {
#   value = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
# }