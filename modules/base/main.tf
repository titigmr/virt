terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}

### VOLUME POOL


resource "libvirt_pool" "pool" {
  name = var.pool
  type = "dir"
  path = "/var/opt/vm/${var.pool}_storage"
}


### NETWORK POOL

resource "libvirt_network" "net" {
  name = "${var.pool}"
  mode = var.net_mode
  domain = "${var.pool}.local"
  addresses = [var.cidr]
  autostart = true

  dhcp {
    enabled = var.enable_dhcp
  }

  dns {
    enabled = var.enable_local_dns
    local_only = false

    dynamic "hosts" {
      for_each = {for n in range(var.number_host) : "${var.hostname}-${n}" => cidrhost(var.cidr, n + 10)}

      content {
        hostname = hosts[each.key]
        ip = hosts[each.value]
      }
    }

    # (Optional) one or more DNS host entries.  Both of
    # "ip" and "hostname" must be specified.  The format is:
    # hosts  {
    #     hostname = "my_hostname"
    #     ip = "my.ip.address.1"
    #   }
    # hosts {
    #     hostname = "my_hostname"
    #     ip = "my.ip.address.2"
    #   }
    #
  }
}
### IMAGES

# To prevent error: Permission denied
# Changing /etc/libvirt/qemu.conf
# Uncomment user/group to work as root and security_driver = "none"
# Then restart libvirtd : sudo service libvirtd restart

resource "libvirt_volume" "image" {
  name   = "debian-11"
  source = "${path.root}/../image/debian-11-generic-amd64.qcow2"
  #source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2"
}