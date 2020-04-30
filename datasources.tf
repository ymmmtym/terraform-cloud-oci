# variable "COMPARTMENT_OCID" {
#   default = var.TENANCY_OCID
# }

# data "oci_identity_availability_domains" "ADs" {
#   compartment_id = var.TENANCY_OCID
# }

# output "ADprint" {
#   value = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
# }