output "corral_node_pools" {
  value = {
    init = [for droplet in [digitalocean_droplet.node[0]] : {
      name = droplet.name
      user = "root"
      address = droplet.ipv4_address
    }]
  }
}

output "kube_api_host" {
  value = ""
}

output "rancher_host" {
  value = ""
}

