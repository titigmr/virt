terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}

### VOLUME POOL

locals {
  entries = var.net == "default" ? null : {
  for n in range(var.number_host) : "${var.hostname}-${n}" => cidrhost(var.net_config.cidr, n + 10) }
}


resource "libvirt_pool" "pool" {
  name = var.pool
  type = "dir"
  path = "/var/opt/vm/${var.pool}_storage"
}


### NETWORK POOL

resource "libvirt_network" "net" {
  count     = var.net == "default" ? 0 : 1
  name      = var.pool
  mode      = var.net_config.net_mode
  domain    = "${var.pool}.local"
  addresses = [var.net_config.cidr]
  autostart = true

  dhcp {
    enabled = var.net_config.enable_dhcp
  }

  dns {
    enabled    = var.net_config.enable_local_dns
    local_only = false

    dynamic "hosts" {
      for_each = local.entries

      content {
        hostname = hosts.key
        ip       = hosts.value
      }
    }

    # (Optional) one or more DNS host entries.  Both of
    # "ip" and "hostname" must be specified.  The format is:
    # hosts  {
    #     hostname = "hostname"
    #     ip = "10.0.3.10"
    #   }
    # hosts {
    #     hostname = "hostname2"
    #     ip = "10.0.3.20"
    #   }
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