resource "oci_core_instance" "ubuntu" {
  count               = 2
  availability_domain = oci_core_subnet.subnet01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = var.INSTANCE_SHAPE
  display_name        = "ubuntu0${count.index + 1}"
  create_vnic_details {
    subnet_id              = oci_core_subnet.subnet01.id
    display_name           = "ubuntu0${count.index + 1}-vnic0${count.index + 1}"
    assign_public_ip       = true
    skip_source_dest_check = true
    hostname_label         = "ubuntu0${count.index + 1}"
  }
  source_details {
    source_id   = var.INSTANCE_SOURCE_OCID
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = "${var.SSH_PUBLIC_KEY}"
    # user_data           = base64encode(file("./userdata/cloud-init-ubuntu.yml"))
  }
  provisioner "file" {
    source      = "provisioning/provisioning-ubuntu.sh"
    destination = "/tmp/provisioning-ubuntu.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provisioning-ubuntu.sh",
      "/tmp/provisioning-ubuntu.sh ${oci_core_subnet.subnet02.cidr_block} oracle01.private.vcn01.oraclevcn.com",
    ]
  }
}

resource "oci_core_instance" "oracle_linux" {
  count = 2
  # count               = 4 # [TBD] Out of host capacity.
  availability_domain = oci_core_subnet.subnet02.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = "VM.Standard.A1.Flex"
  display_name        = "oracle0${count.index + 1}"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet02.id
    display_name     = "oracle0${count.index + 1}-vnic0${count.index + 1}"
    assign_public_ip = false
    hostname_label   = "oracle0${count.index + 1}"
  }
  source_details {
    source_id   = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaakjxlsfb6ltwp7lqhr4owgvwvwtgskjfcwoium6pr35lp2hw4guvq"
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = "${var.SSH_PUBLIC_KEY}"
    # user_data           = base64encode(file("./userdata/cloud-init-oracle.yml"))
  }
  provisioner "file" {
    source      = "provisioning/provisioning-oracle-linux.sh"
    destination = "/tmp/provisioning-oracle-linux.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/provisioning-oracle-linux.sh",
      "/tmp/provisioning-oracle-linux.sh",
    ]
  }
  depends_on = [
    oci_core_instance.ubuntu
  ]
}

# output ip addresses
output "public_ips" {
  value       = oci_core_instance.ubuntu.*.public_ip
  description = "Public IPs of bastion instances"
}

output "private_ips" {
  value       = concat(oci_core_instance.ubuntu.*.private_ip, oci_core_instance.oracle_linux.*.private_ip)
  description = "Private IPs of all instances"
}
