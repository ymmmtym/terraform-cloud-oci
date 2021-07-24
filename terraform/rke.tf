resource "rke_cluster" "cluster" {
  nodes {
    address          = oci_core_instance.ubuntu01.*.public_ip
    internal_address = oci_core_instance.ubuntu01.*.private_ip
    user             = "ubuntu"
    ssh_key          = file("~/.ssh/id_rsa")
    role             = ["controlplane", "worker", "etcd"]
  }
  nodes {
    address          = oci_core_instance.ubuntu02.*.public_ip
    internal_address = oci_core_instance.ubuntu02.*.private_ip
    user             = "ubuntu"
    ssh_key          = file("~/.ssh/id_rsa")
    role             = ["worker"]
  }
  nodes {
    address          = oci_core_instance.ubuntu03.*.public_ip
    internal_address = oci_core_instance.ubuntu03.*.private_ip
    user             = "ubuntu"
    ssh_key          = file("~/.ssh/id_rsa")
    role             = ["worker"]
  }
  nodes {
    address          = oci_core_instance.ubuntu04.*.public_ip
    internal_address = oci_core_instance.ubuntu04.*.private_ip
    user             = "ubuntu"
    ssh_key          = file("~/.ssh/id_rsa")
    role             = ["worker"]
  }
  network {
    plugin = "flannel"
  }

  delay_on_creation = 10
}