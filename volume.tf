
# To prevent error: Permission denied
# Changing /etc/libvirt/qemu.conf
# Uncomment user/group to work as root and security_driver = "none"
# Then restart libvirtd : sudo service libvirtd restart

resource "libvirt_volume" "image" {
  name   = "debian-11"
  source = "image/debian-11-generic-amd64.qcow2"
  #source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-generic-amd64.qcow2"
}

# INFO: size parameters is in bytes
resource "libvirt_volume" "volume" {
  name           = "${var.hostname}-volume"
  base_volume_id = libvirt_volume.image.id
  pool           = "${var.pool}"
  size           = var.volume_size * 1000000000

depends_on = [
  libvirt_pool.pool
]

}
