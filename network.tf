resource "oci_core_virtual_network" "vcn01" {
  cidr_block = "192.168.0.0/16"
  compartment_id = var.COMPARTMENT_OCID
  display_name = "vcn01"
  dns_label = "vcn01"
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
    protocol = "6"
    stateless = false
  }
  ingress_security_rules {
    source = "0.0.0.0/0"
    protocol = "6"
    stateless = false
    tcp_options {
      max = "22"
      min = "22"
    }
    description = "ssh"
  }
  ingress_security_rules {
    source = "0.0.0.0/0"
    protocol = "6"
    stateless = false
    tcp_options {
      max = "80"
      min = "80"
    }
    description = "http-server"
  }
  ingress_security_rules {
    source = "0.0.0.0/0"
    protocol = "6"
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
  dns_label = "vcn01"
  security_list_ids = [oci_core_security_list.sl_web.id]
  compartment_id = var.COMPARTMENT_OCID
  vcn_id = oci_core_virtual_network.vcn01.id
  route_table_id = oci_core_route_table.rt01.id
  prohibit_public_ip_on_vnic = false
}

resource "oci_load_balancer_load_balancer" "lb01" {
  compartment_id = var.COMPARTMENT_OCID
  display_name   = "lb01"
  shape          = "flexible" # always free
  shape_details {
      maximum_bandwidth_in_mbps = 10
      minimum_bandwidth_in_mbps = 10
  }
  is_private     = false
  reserved_ips {
    id = data.oci_core_public_ip.public_ip01.id
  }
  subnet_ids = [
    oci_core_subnet.subnet01.id
  ]
}

resource "oci_load_balancer_backend_set" "lb01_bes" {
  name             = "lb01_bes"
  load_balancer_id = oci_load_balancer_load_balancer.lb01.id
  policy           = "ROUND_ROBIN"
  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
  session_persistence_configuration {
  cookie_name      = "lb01_session1"
  disable_fallback = true
  }
}

resource "oci_load_balancer_backend" "lb01_be01" {
  backendset_name = oci_load_balancer_backend_set.lb01_bes.name
  ip_address = oci_core_instance.ubuntu01[0].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.lb01.id
  port = "80"
}

resource "oci_load_balancer_backend" "lb01_be02" {
  backendset_name = oci_load_balancer_backend_set.lb01_bes.name
  ip_address = oci_core_instance.ubuntu02[0].private_ip
  load_balancer_id = oci_load_balancer_load_balancer.lb01.id
  port = "80"
}

resource "oci_load_balancer_listener" "load_balancer_listener0" {
  load_balancer_id         = oci_load_balancer_load_balancer.lb01.id
  name                     = "http"
  default_backend_set_name = oci_load_balancer_backend_set.lb01_bes.name
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "120"
  }
}

# output ip addresses
output "lb01" {
  value = oci_load_balancer_load_balancer.lb01.ip_address_details
}