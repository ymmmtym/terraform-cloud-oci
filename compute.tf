# resource "oci_core_instance" "ubuntu03" {
#     count = "1"
#     availability_domain = oci_core_subnet.subnet01.availability_domain
#     compartment_id = var.COMPARTMENT_OCID
#     shape = "VM.Standard2.1.Micro"
#     display_name = "ubuntu03"
#     create_vnic_details {
#         subnet_id = oci_core_subnet.subnet01.id
#     }
#     source_details {
#         source_id = var.instance_image_ocid[var.REGION]
#         source_type = "image"
#     }
#     metadata {
#         ssh_authorized_keys = var.SSH_PUBLIC_KEY
#     }
#     # defined_tags = map(var.defined_tag,  var.defined_tag_value)
# }