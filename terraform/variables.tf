variable "TENANCY_OCID" {}
variable "USER_OCID" {}
variable "FINGERPRINT" {}
variable "PRIVATE_KEY" {}
variable "PRIVATE_KEY_PASSWORD" {}
variable "PRIVATE_KEY_INSTANCE" {}
variable "REGION" {
  default = "ap-tokyo-1"
}
variable "AVAILABILITY_ZONE" {
  default = "ZMzB:AP-TOKYO-1-AD-1"
}
variable "COMPARTMENT_OCID" {}
variable "SSH_PUBLIC_KEY" {}
variable "INSTANCE_SHAPE" {
  default = "VM.Standard.E2.1.Micro"
}
variable "INSTANCE_SOURCE_OCID" {
  default = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaat4kfe427svas2tocgp3sz6py6hr3od7tgsohuw43lm3fl3gcioiq"
}
variable "VOLUME_ATTACHMENT_ATTACHMENT_TYPE" {
  default = "paravirtualized"
}
variable "CIDR_VCN01" {
  default = "192.168.0.0/16"
}
variable "CIDR_SUBNET01" {
  default = "192.168.0.0/24"
}
variable "CIDR_SUBNET02" {
  default = "192.168.1.0/24"
}