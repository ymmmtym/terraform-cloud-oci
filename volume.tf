resource "oci_core_volume" "bs01" {
  compartment_id      = var.COMPARTMENT_OCID
  availability_domain = var.AVAILABILITY_ZONE
  display_name = "bs01"
}

resource "oci_core_volume_attachment" "bs01_attachment" {
  attachment_type = var.VOLUME_ATTACHMENT_ATTACHMENT_TYPE
  instance_id     = oci_core_instance.ubuntu01.0.id
  volume_id       = oci_core_volume.bs01.id
}

resource "oci_core_volume" "bs02" {
  compartment_id      = var.COMPARTMENT_OCID
  availability_domain = var.AVAILABILITY_ZONE
  display_name = "bs02"
}

resource "oci_core_volume_attachment" "bs02_attachment" {
  attachment_type = var.VOLUME_ATTACHMENT_ATTACHMENT_TYPE
  instance_id     = oci_core_instance.ubuntu02.0.id
  volume_id       = oci_core_volume.bs02.id
}