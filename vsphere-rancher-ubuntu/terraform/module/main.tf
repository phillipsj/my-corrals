provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = var.vsphere_self_signed_ssl
}

provider "random" {}

resource "random_id" "cluster_id" {
  byte_length       = 6
}

resource "random_id" "rancher_host" {
  byte_length       = 6
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_content_library" "library" {
  name = var.vsphere_content_library
}

data "vsphere_content_library_item" "item" {
  name       = var.vsphere_template_name
  library_id = data.vsphere_content_library.library.id
  type       = "vm-template"
}

resource "vsphere_virtual_machine" "vm" {
  name             = "${var.corral_user_id}-${random_id.cluster_id.hex}-rancher"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 8192

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  clone {
    template_uuid = data.vsphere_content_library_item.item.id
  }

}
resource "digitalocean_ssh_key" "corral_key" {
  name       = "corral-${var.corral_user_id}-${random_id.cluster_id.hex}"
  public_key = var.corral_public_key
}

resource "digitalocean_droplet" "node" {
  count = 1

  name = "${var.corral_user_id}-${random_id.cluster_id.hex}-cp-${count.index}"
  image    = "ubuntu-20-04-x64"
  region   = "sfo3"
  size     = "s-2vcpu-4gb"
  tags = [var.corral_user_id, var.corral_name]
  ssh_keys = [digitalocean_ssh_key.corral_key.id]
}

