variable "INSTANCE_SHAPE" {
  default = "VM.Standard.E2.1.Micro"
}
variable "INSTANCE_SOURCE_OCID" {
  default = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaat4kfe427svas2tocgp3sz6py6hr3od7tgsohuw43lm3fl3gcioiq"
}

resource "oci_core_instance" "ubuntu01" {
  count               = "1"
  availability_domain = oci_core_subnet.subnet01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = var.INSTANCE_SHAPE
  display_name        = "ubuntu01"
  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet01.id
    private_ip       = "192.168.0.2"
    display_name     = "vnic01"
    assign_public_ip = true
    hostname_label   = "ubuntu01"
  }
  source_details {
    source_id   = var.INSTANCE_SOURCE_OCID
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = var.SSH_PUBLIC_KEY
  }
}
resource "oci_core_instance" "ubuntu02" {
  count               = "1"
  availability_domain = oci_core_subnet.subnet01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = var.INSTANCE_SHAPE
  display_name        = "ubuntu02"
  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet01.id
    private_ip       = "192.168.0.3"
    display_name     = "vnic01"
    assign_public_ip = true
    hostname_label   = "ubuntu02"
  }
  source_details {
    source_id   = var.INSTANCE_SOURCE_OCID
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = var.SSH_PUBLIC_KEY
  }
}

# output ip addresses
output "ubuntu01" {
  value = oci_core_instance.ubuntu01.*.public_ip
}
output "ubuntu02" {
  value = oci_core_instance.ubuntu02.*.public_ip
}