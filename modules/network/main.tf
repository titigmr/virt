terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}


### Networks

resource "libvirt_network" "net" {
  count     = var.domain == "default" ? 0 : 1
  name      = var.domain
  mode      = var.net_mode
  domain    = "${var.domain}.local"
  addresses = [var.cidr] 
  autostart = true

  dhcp {
    enabled = var.enable_dhcp
  }

  # dns {
  #   enabled    = var.enable_local_dns
  #   local_only = false

  #   dynamic "hosts" {
  #     for_each =  var.net == "default" ? null : var.entries

  #     content {
  #       hostname = hosts.key
  #       ip       = hosts.value
  #     }
  #   }

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
  #}
}
