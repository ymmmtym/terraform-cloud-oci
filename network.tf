resource "oci_core_virtual_network" "vcn01" {
  cidr_block = "192.168.0.0/16"
  compartment_id = var.COMPARTMENT_OCID
  display_name = "vcn01"
}

resource "oci_core_internet_gateway" "ig01" {
  compartment_id = var.COMPARTMENT_OCID
  display_name = "ig01"
  vcn_id = oci_core_virtual_network.vcn01.id
}

# resource "oci_core_route_table" "rt01" {
#   compartment_id = var.COMPARTMENT_OCID
#   vcn_id = oci_core_virtual_network.vcn01.id
#   display_name = "rt01"
#   route_rules {
#     destination = "0.0.0.0/0"
#     network_entity_id = "oci_core_internet_gateway.ig01.id"
#   }
# }

# resource "oci_core_security_list" "sl_web" {
#     compartment_id = var.COMPARTMENT_OCID
#     egress_security_rules {
#         destination = "0.0.0.0/0"
#         protocol = "TCP"
#         stateless = false
#     }
    # ingress_security_rules {
    #     source = "${var.sl_ingress_source_web}"          # 必須
    #     protocol = "${var.sl_ingress_protocol_web}"      # 必須
    #     stateless = false
    #     tcp_options {
    #         max = "${var.sl_ingress_tcp_dest_port_max_web}"
    #         min = "${var.sl_ingress_tcp_dest_port_min_web}"
    #     }
    # }
#     vcn_id = oci_core_vcn.vcn01.id
#     display_name = "sl_web"
# }

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