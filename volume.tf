resource "libvirt_pool" "cluster" {
  name = "cluster"
  type = "dir"
  path = "/var/opt/cluster_storage"
}

resource "libvirt_volume" "os_image" {
  name   = "debian-11"
  pool   = "cluster"
  #source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-nocloud-amd64.qcow2"
  source = "./debian-11-nocloud-amd64.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "disk_resized" {
  name           = "${var.hostname}-volume"
  base_volume_id = libvirt_volume.os_image.id
  pool           = "cluster"
  size           = 10
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit_disk" "cloudinit_ubuntu_resized" {
  name = "cloudinit_ubuntu_resized.iso"
  pool = "cluster"

  user_data = <<EOF
#cloud-config
disable_root: 0
ssh_pwauth: 1
users:
  - name: root
    ssh-authorized-keys:
      - ${file("id_rsa.pub")}
growpart:
  mode: auto
  devices: ['/']
EOF
}
