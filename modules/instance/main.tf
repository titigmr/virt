terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}

### INSTANCE

locals {
  entries = var.entries == null ? { for n in range(var.number_host) : "${var.hostname}-${n}" => null } : var.entries
}

resource "libvirt_domain" "domain" {
  for_each  = local.entries
  name      = each.key
  memory    = var.ram * 1024
  vcpu      = var.cpu
  autostart = true
  cloudinit = libvirt_cloudinit_disk.init.id

  cpu {
    mode = "host-passthrough"
  }

  disk {
    volume_id = libvirt_volume.volume[each.key].id
  }

  # IMPORTANT
  # Ubuntu/Debian can hang if an isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  network_interface {
    network_name   = var.net
    addresses      = each.value == null ? null : [each.value]
    wait_for_lease = true
  }

  # Enable VNC on localhost address
  graphics {
    type        = "vnc"
    listen_type = "address"
  }
}

### CLOUD-INIT

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.root}/../config/cloud-init.yaml",
      {}
    )
  }

  part {
    content_type = "text/plain"
    content = templatefile("${path.root}/../config/noop.sh",
    { VERSION = "v1.0" })
  }
}

resource "libvirt_cloudinit_disk" "init" {
  name      = "${var.hostname}-init.iso"
  pool      = var.pool
  user_data = data.template_cloudinit_config.config.rendered
}


### VOLUME

# INFO: size parameters is in bytes : 1Go(fr) = 1GB(en) = 1.074e+9 bytes = 1Gb * 8
resource "libvirt_volume" "volume" {
  for_each       = toset([for n in range(var.number_host) : "${var.hostname}-${n}"])
  name           = "${each.key}-volume"
  base_volume_id = var.image_id
  pool           = var.pool
  size           = var.volume_size * 1.074e+9
}
