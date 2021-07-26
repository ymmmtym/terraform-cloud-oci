resource "rke_cluster" "cluster" {
  nodes {
    address = oci_core_instance.oracle_linux.0.private_ip
    user    = "opc"
    ssh_key = var.PRIVATE_KEY
    role    = ["controlplane", "worker", "etcd"]
  }
  bastion_host {
    address        = oci_core_instance.ubuntu.0.public_ip
    user           = "ubuntu"
    ssh_agent_auth = true
    ssh_key        = var.PRIVATE_KEY
  }
  network {
    plugin = "flannel"
  }

  delay_on_creation = 10
}
