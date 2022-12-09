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


### IMAGES

# To prevent error: Permission denied
# Changing /etc/libvirt/qemu.conf
# Uncomment user/group to work as root and security_driver = "none"
# Then restart libvirtd : sudo service libvirtd restart

resource "libvirt_volume" "image" {
  name   = "debian-11"
  source = "${path.root}/../../image/debian-11-generic-amd64.qcow2"
  #source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2"
}
