resource "oci_core_instance" "ubuntu01" {
    count = "1"
    availability_domain = oci_core_subnet.subnet01.availability_domain
    compartment_id = var.COMPARTMENT_OCID
    shape = "VM.Standard.E2.1.Micro"
    display_name = "ubuntu01"
    create_vnic_details {
        subnet_id = oci_core_subnet.subnet01.id
        private_ip = "192.168.0.2"
        display_name     = "vnic01"
        assign_public_ip = false
        hostname_label   = "ubuntu01"
    }
    source_details {
        source_id = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaat4kfe427svas2tocgp3sz6py6hr3od7tgsohuw43lm3fl3gcioiq"
        source_type = "image"
    }
    metadata = {
        ssh_authorized_keys = var.SSH_PUBLIC_KEY
    }
}
resource "oci_core_instance" "ubuntu02" {
    count = "1"
    availability_domain = oci_core_subnet.subnet01.availability_domain
    compartment_id = var.COMPARTMENT_OCID
    shape = "VM.Standard.E2.1.Micro"
    display_name = "ubuntu02"
    create_vnic_details {
        subnet_id = oci_core_subnet.subnet01.id
        private_ip = "192.168.0.3"
        display_name     = "vnic01"
        assign_public_ip = true
        hostname_label   = "ubuntu02"
    }
    source_details {
        source_id = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaat4kfe427svas2tocgp3sz6py6hr3od7tgsohuw43lm3fl3gcioiq"
        source_type = "image"
    }
    metadata = {
        ssh_authorized_keys = var.SSH_PUBLIC_KEY
    }
}

# assing public ip to vnic of ubuntu01
data "oci_core_vnic_attachments" "ubuntu01_vnics" {
  compartment_id      = var.COMPARTMENT_OCID
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[0],"name")
  instance_id         = oci_core_instance.ubuntu01[0].id
}
data "oci_core_vnic" "ubuntu01_vnic01" {
  vnic_id = lookup(data.oci_core_vnic_attachments.ubuntu01_vnics.vnic_attachments[0], "vnic_id")
}
data "oci_core_private_ips" "ubuntu01_private_ips" {
  vnic_id = data.oci_core_vnic.ubuntu01_vnic01.id
}
resource "oci_core_public_ip" "public_ip01" {
  compartment_id = var.COMPARTMENT_OCID
  lifetime       = "RESERVED"
  display_name   = "public_ip01"
  private_ip_id  = lookup(data.oci_core_private_ips.ubuntu01_private_ips.private_ips[0], "id")
#   private_ip_id  = lookup(data.oci_core_instance.ubuntu01[0].create_vnic_details[0].private_ip, "id")
}

# output ip addresses
output "ubuntu01" {
  value = lookup(oci_core_instance.ubuntu01[0], "public_ip")
}
output "ubuntu02" {
  value = lookup(oci_core_instance.ubuntu02[0], "public_ip")
}