resource "rke_cluster" "cluster" {
  nodes {
    address          = oci_core_instance.ubuntu01[0].public_ip
    internal_address = oci_core_instance.ubuntu01[0].private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY
    role             = ["controlplane", "worker", "etcd"]
  }
  nodes {
    address          = oci_core_instance.ubuntu02[0].public_ip
    internal_address = oci_core_instance.ubuntu02[0].private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY
    role             = ["worker"]
  }
  nodes {
    address          = oci_core_instance.ubuntu03[0].public_ip
    internal_address = oci_core_instance.ubuntu03[0].private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY
    role             = ["worker"]
  }
  nodes {
    address          = oci_core_instance.ubuntu04[0].public_ip
    internal_address = oci_core_instance.ubuntu04[0].private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY
    role             = ["worker"]
  }
  network {
    plugin = "flannel"
  }

  delay_on_creation = 10
}