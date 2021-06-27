resource "oci_core_volume" "bv01" {
  compartment_id      = var.COMPARTMENT_OCID
  availability_domain = var.AVAILABILITY_ZONE
  display_name        = "bv01"
}

resource "oci_core_volume_attachment" "bv01_attachment" {
  attachment_type = var.VOLUME_ATTACHMENT_ATTACHMENT_TYPE
  instance_id     = oci_core_instance.ubuntu01.0.id
  volume_id       = oci_core_volume.bv01.id
}

resource "oci_core_volume" "bv02" {
  compartment_id      = var.COMPARTMENT_OCID
  availability_domain = var.AVAILABILITY_ZONE
  display_name        = "bv02"
}

resource "oci_core_volume_attachment" "bv02_attachment" {
  attachment_type = var.VOLUME_ATTACHMENT_ATTACHMENT_TYPE
  instance_id     = oci_core_instance.ubuntu02.0.id
  volume_id       = oci_core_volume.bv02.id
}