# Make sure add key in ssh agent
# ssh-add ~/.ssh/id_rsa
# or add "/system?keyfile=~/.ssh/id_rsa"
provider "libvirt" {
  uri = "qemu+ssh://root@192.168.0.100/system"
}

terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}