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

resource "oci_core_route_table" "rt01" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id = oci_core_virtual_network.vcn01.id
  display_name = "rt01"
  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.ig01.id
  }
}

resource "oci_core_security_list" "sl_web" {
    compartment_id = var.COMPARTMENT_OCID
    egress_security_rules {
        destination = "0.0.0.0/0"
        protocol = "TCP"
        stateless = false
    }
    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "TCP"
        stateless = false
        tcp_options {
            max = "22"
            min = "22"
        }
        description = "ssh"
    }
    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "TCP"
        stateless = false
        tcp_options {
            max = "80"
            min = "80"
        }
        description = "http-server"
    }
    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "TCP"
        stateless = false
        tcp_options {
            max = "443"
            min = "443"
        }
        description = "https-server"
    }
    vcn_id = oci_core_virtual_network.vcn01.id
    display_name = "sl_web"
}

resource "oci_core_subnet" "subnet01" {
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
  cidr_block = "192.168.0.0/24"
  display_name = "subnet01"
  dns_label = "subnet01"
  security_list_ids = [oci_core_security_list.sl_web.id]
  compartment_id = var.COMPARTMENT_OCID
  vcn_id = oci_core_virtual_network.vcn01.id
  route_table_id = oci_core_route_table.rt01.id
  dhcp_options_id = oci_core_virtual_network.vcn01.default_dhcp_options_id
}