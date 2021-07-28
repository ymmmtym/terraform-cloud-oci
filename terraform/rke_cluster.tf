resource "rke_cluster" "cluster" {
  nodes {
    address = oci_core_instance.oracle_linux.0.private_ip
    user    = "opc"
    ssh_key = var.PRIVATE_KEY_INSTANCE
    role    = ["controlplane", "worker", "etcd"]
  }
  nodes {
    address = oci_core_instance.oracle_linux.1.private_ip
    user    = "opc"
    ssh_key = var.PRIVATE_KEY_INSTANCE
    role    = ["worker"]
  }
  # nodes { # [TBD] Out of host capacity.
  #   address = oci_core_instance.oracle_linux.2.private_ip
  #   user    = "opc"
  #   ssh_key = var.PRIVATE_KEY_INSTANCE
  #   role    = ["worker"]
  # }
  # nodes { # [TBD] Out of host capacity.
  #   address = oci_core_instance.oracle_linux.3.private_ip
  #   user    = "opc"
  #   ssh_key = var.PRIVATE_KEY_INSTANCE
  #   role    = ["worker"]
  # }
  bastion_host {
    address        = oci_core_instance.ubuntu.0.public_ip
    user           = "ubuntu"
    ssh_agent_auth = false
    ssh_key        = var.PRIVATE_KEY_INSTANCE
  }
  network {
    plugin = "flannel"
  }
  restore {
    restore = false
  }
  delay_on_creation = 90
}