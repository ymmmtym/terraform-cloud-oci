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
        hostname_label   = "freeinstance0"
    }
    source_details {
        source_id = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaat4kfe427svas2tocgp3sz6py6hr3od7tgsohuw43lm3fl3gcioiq"
        source_type = "image"
    }
    metadata = {
        ssh_authorized_keys = var.SSH_PUBLIC_KEY
    }
    # defined_tags = map(var.defined_tag,  var.defined_tag_value)
}