resource "oci_core_virtual_network" "vcn01" {
  cidr_block = "192.168.0.0/16"
  compartment_id = "${var.TENANCY_OCID}"
  display_name = "vcn01"
}

resource "oci_core_internet_gateway" "ig01" {
  compartment_id = "${var.TENANCY_OCID}"
  display_name = "ig01"
  vcn_id = "${oci_core_virtual_network.vcn01.id}"
}

# resource "oci_core_subnet" "subnet01" {
#   availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[var.AD - 1],"name")}"
#   cidr_block = "192.168.0.0/24"
#   display_name = "subnet01"
#   dns_label = "subnet01"
#   security_list_ids = ["${oci_core_virtual_network.ExampleVCN.default_security_list_id}"]
#   compartment_id = "${var.compartment_ocid}"
#   vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
#   route_table_id = "${oci_core_route_table.ExampleRT.id}"
#   dhcp_options_id = "${oci_core_virtual_network.ExampleVCN.default_dhcp_options_id}"
# }

# resource "oci_core_route_table" "ExampleRT" {
#   compartment_id = "${var.compartment_ocid}"
#   vcn_id = "${oci_core_virtual_network.ExampleVCN.id}"
#   display_name = "TFExampleRouteTable"
#   route_rules {
#     cidr_block = "0.0.0.0/0"
#     network_entity_id = "${oci_core_internet_gateway.ExampleIG.id}"
#   }
# }
