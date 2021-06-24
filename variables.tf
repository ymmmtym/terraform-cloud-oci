variable "TENANCY_OCID" {}
variable "USER_OCID" {}
variable "FINGERPRINT" {}
variable "PRIVATE_KEY" {}
variable "PRIVATE_KEY_PASSWORD" {}
variable "REGION" {
  default = "ap-tokyo-1"
}
variable "COMPARTMENT_OCID" {}
variable "SSH_PUBLIC_KEY" {}
variable "INSTANCE_SHAPE" {
  default = "VM.Standard.E2.1.Micro"
}
variable "INSTANCE_SOURCE_OCID" {
  default = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaat4kfe427svas2tocgp3sz6py6hr3od7tgsohuw43lm3fl3gcioiq"
}