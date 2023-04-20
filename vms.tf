resource "digitalocean_droplet" "servers" {
    count = 3
    image = "ubuntu-20-04-x64"
    name = "server-${count.index}"
    region = "nyc3"
    size = "s-1vcpu-1gb"

    ssh_keys = [
      data.digitalocean_ssh_key.europa.id
    ]
}

resource "digitalocean_droplet" "clients" {
    count = 5
    image = "ubuntu-20-04-x64"
    name = "client-${count.index}"
    region = "nyc3"
    size = "s-1vcpu-1gb"

    ssh_keys = [
      data.digitalocean_ssh_key.europa.id
    ]
}

output "nomad_servers" {
  value = {
    for droplet in digitalocean_droplet.servers:
    droplet.name => droplet.ipv4_address
  }
}

output "nomad_clients" {
  value = {
    for droplet in digitalocean_droplet.clients:
    droplet.name => droplet.ipv4_address
  }
}
