# data "oci_identity_availability_domains" "ads" {
#   compartment_id = var.COMPARTMENT_OCID
# }

# output "ADs" {
#   value = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
# }