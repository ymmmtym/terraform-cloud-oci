provider "rke" {
  debug = true
}
resource "rke_cluster" "cluster" {
  nodes {
    address          = oci_core_instance.kubernetes.0.public_ip
    internal_address = oci_core_instance.kubernetes.0.private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY_INSTANCE
    role             = ["controlplane", "worker", "etcd"]
  }
  nodes {
    address          = oci_core_instance.kubernetes.1.public_ip
    internal_address = oci_core_instance.kubernetes.1.private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY_INSTANCE
    role             = ["worker"]
  }
  nodes {
    address          = oci_core_instance.kubernetes.2.public_ip
    internal_address = oci_core_instance.kubernetes.2.private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY_INSTANCE
    role             = ["worker"]
  }
  nodes {
    address          = oci_core_instance.kubernetes.3.public_ip
    internal_address = oci_core_instance.kubernetes.3.private_ip
    user             = "ubuntu"
    ssh_key          = var.PRIVATE_KEY_INSTANCE
    role             = ["worker"]
  }
  network {
    plugin = "flannel"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = oci_core_instance.kubernetes.0.public_ip
      private_key = var.PRIVATE_KEY_INSTANCE
    }
    scripts = [
      "provisioning/install-kubectl.sh",
    ]
  }
  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = oci_core_instance.kubernetes.0.public_ip
      private_key = var.PRIVATE_KEY_INSTANCE
    }
    content     = rke_cluster.cluster.kube_config_yaml
    destination = "~/.kube/config"
  }
}