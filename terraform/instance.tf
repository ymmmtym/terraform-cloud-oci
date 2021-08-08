resource "oci_core_instance" "kubernetes" {
  count = 2
  # count               = 4 # [TBD] Out of host capacity.
  availability_domain = oci_core_subnet.subnet01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = "VM.Standard.A1.Flex"
  display_name        = "ubuntu0${count.index + 1}"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

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
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = self.public_ip
      private_key = var.PRIVATE_KEY_INSTANCE
    }
    scripts = [
      "provisioning/provisioning.sh",
    ]
  }
}

output "public_ips" {
  value       = oci_core_instance.kubernetes.*.public_ip
  description = "Public IPs of instances"
}

output "private_ips" {
  value       = oci_core_instance.kubernetes.*.private_ip
  description = "Private IPs of instances"
}
