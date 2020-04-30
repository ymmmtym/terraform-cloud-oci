data "oci_identity_availability_domains" "ads" {
  compartment_id = var.COMPARTMENT_OCID
}

data "oci_core_instance" "ubuntu01" {
  instance_id = "ocid1.instance.oc1.ap-tokyo-1.anxhiljrhki6czacqpkyum7snuooahii4mcx7hvznuynnuo6fgwnw6z7dnsa"
}

output "ADs" {
  value = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
}

output "instance" {
  value = data.oci_core_instance.ubuntu01
}