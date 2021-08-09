provider "kubernetes" {
  host                   = rke_cluster.cluster.api_server_url
  username               = rke_cluster.cluster.kube_admin_user
  client_certificate     = rke_cluster.cluster.client_cert
  client_key             = rke_cluster.cluster.client_key
  cluster_ca_certificate = rke_cluster.cluster.ca_crt
}