data "oci_identity_availability_domains" "ads" {
  compartment_id = var.COMPARTMENT_OCID
}

data "oci_core_public_ip" "public_ip01" {
  ip_address = "132.145.118.149"
}

data "oci_core_private_ips" "ubuntu01_private_ips" {
  ip_address = oci_core_instance.ubuntu.0.private_ip
  subnet_id  = oci_core_subnet.subnet01.id
}

data "oci_core_private_ips" "ubuntu02_private_ips" {
  ip_address = oci_core_instance.ubuntu.1.private_ip
  subnet_id  = oci_core_subnet.subnet01.id
}
