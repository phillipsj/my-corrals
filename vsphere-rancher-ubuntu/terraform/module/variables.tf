variable "corral_name" {}
variable "corral_user_id" {}
variable "corral_user_public_key" {}
variable "corral_public_key" {}

variable "rancher_version" {
  description = "Rancher version to deploy."
  default = ""
}

variable "vsphere_content_library" {
  description = "vSphere content library name."
  type = string
}

variable "vsphere_datacenter" {
  description = "vSphere vCenter data center."
  type = string
}

variable "vsphere_datastore" {
  description = "vSphere vCenter data store."
  type = string
}

variable "vsphere_network" {
  description = "vSphere vCenter network name."
  type = string
}

variable "vsphere_password" {
  description = "vSphere vCenter password."
  type = string
}
variable "vsphere_resource_pool" {
  description = "vSphere vCenter resource pool."
  type = string
}
variable "vsphere_self_signed_ssl" {
  description = "Boolean if you are using a self-signed cert or not for SSL."
  type = bool
  default = true
}
variable "vsphere_server" {
  description = "vSphere vCenter hostname."
  type = string
}

variable "vsphere_template_name" {
  description = "Name of the content library template name."
  type = string
}
variable "vsphere_user" {
  description = "vSphere vCenter username"
  type = string
}
