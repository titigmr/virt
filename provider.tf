terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}

provider "libvirt" {
    uri = "qemu+ssh://root@192.168.0.100/system"
}