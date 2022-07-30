


resource "libvirt_domain" "domain" {
  name   = "${var.hostname}"
  memory = var.memoryMB
  vcpu   = var.cpu

  disk {
        volume_id = libvirt_volume.volume.id
  }

  network_interface {
       network_name = "default"
  }
  #cloudinit = libvirt_cloudinit_disk.commoninit.id
}

output "ips" {
  value = libvirt_domain.domain.*.network_interface.0.addresses
}