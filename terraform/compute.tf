resource "oci_core_instance" "ubuntu" {
  count               = 2
  availability_domain = oci_core_subnet.subnet01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = var.INSTANCE_SHAPE
  display_name        = "ubuntu0${count.index + 1}"
  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet01.id
    display_name     = "vnic01"
    assign_public_ip = true
    hostname_label   = "ubuntu0${count.index + 1}"
  }
  source_details {
    source_id   = var.INSTANCE_SOURCE_OCID
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = var.SSH_PUBLIC_KEY
  }
}

resource "oci_core_instance" "oracle01" {
  count               = "1"
  availability_domain = oci_core_subnet.subnet01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = "VM.Standard.A1.Flex"
  display_name        = "oracle01"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet01.id
    display_name     = "vnic01"
    assign_public_ip = false
    hostname_label   = "oracle01"
  }
  source_details {
    source_id   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaakjxlsfb6ltwp7lqhr4owgvwvwtgskjfcwoium6pr35lp2hw4guvq"
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = var.SSH_PUBLIC_KEY
  }
}

# output ip addresses
output "public_ips" {
  value = oci_core_instance.ubuntu.*.public_ip
}