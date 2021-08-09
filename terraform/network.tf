resource "oci_core_virtual_network" "vcn01" {
  cidr_block     = var.CIDR_VCN01
  compartment_id = var.COMPARTMENT_OCID
  display_name   = "vcn01"
  dns_label      = "vcn01"
}

resource "oci_core_internet_gateway" "ig01" {
  compartment_id = var.COMPARTMENT_OCID
  display_name   = "ig01"
  vcn_id         = oci_core_virtual_network.vcn01.id
}

resource "oci_core_route_table" "rt01" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.vcn01.id
  display_name   = "rt01"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.ig01.id
  }
}
resource "oci_core_security_list" "sl01" {
  compartment_id = var.COMPARTMENT_OCID
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
    description = "all"
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "ssh"
    tcp_options {
      min = "22"
      max = "22"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "kubernetes api server"
    tcp_options {
      min = "6443"
      max = "6443"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "etcd"
    tcp_options {
      min = "2376"
      max = "2376"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "etcd"
    tcp_options {
      min = "2379"
      max = "2380"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "17"
    stateless   = false
    description = "Kubernetes UDP"
    udp_options {
      min = "8472"
      max = "8472"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "controlplane"
    tcp_options {
      min = "9099"
      max = "9099"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "etcd"
    tcp_options {
      min = "10250"
      max = "10250"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "controlplane"
    tcp_options {
      min = "10254"
      max = "10254"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "nodeport(TCP)"
    tcp_options {
      min = "30000"
      max = "32767"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "17"
    stateless   = false
    description = "nodeport(UDP)"
    udp_options {
      min = "30000"
      max = "32767"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "all"
    stateless   = false
    description = "all vcn01"
  }
  vcn_id       = oci_core_virtual_network.vcn01.id
  display_name = "sl01"
}
resource "oci_core_subnet" "subnet01" {
  availability_domain        = lookup(data.oci_identity_availability_domains.ads.availability_domains[0], "name")
  cidr_block                 = var.CIDR_SUBNET01
  display_name               = "subnet01"
  dns_label                  = "public"
  security_list_ids          = [oci_core_security_list.sl01.id]
  compartment_id             = var.COMPARTMENT_OCID
  vcn_id                     = oci_core_virtual_network.vcn01.id
  route_table_id             = oci_core_route_table.rt01.id
  prohibit_public_ip_on_vnic = false
}