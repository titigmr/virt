
resource "libvirt_domain" "domain" {
  name   = "${var.hostname}"
  memory = var.ram * 1024
  vcpu   = var.cpu

  disk {
        volume_id = libvirt_volume.volume.id
  }

  # IMPORTANT
  # Ubuntu/Debian can hang if an isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why

  console {
    type = "pty"
    target_port = "0"
    target_type = "serial"
  }

  network_interface {
    network_name = "default"
    wait_for_lease = true
  }

  # Enable VNC on localhost address
  graphics {
    type        = "vnc"
    listen_type = "address"
  }

  cloudinit = libvirt_cloudinit_disk.init.id
}

# CloudInit configuration
resource "libvirt_cloudinit_disk" "init" {
  name = "${var.hostname}-init.iso"
  pool = "${var.pool}"

  user_data = <<EOF
#cloud-config
disable_root: false
ssh_pwauth: true
package_update: true
users:
  - name: root
    ssh-authorized-keys:
      - ${file("id_rsa.pub")}
  - name: debian
    ssh-authorized-keys:
      - ${file("id_rsa.pub")}
    sudo: true
growpart:
  mode: auto
  devices: ['/']
EOF

depends_on = [
  libvirt_pool.pool
]

}
