terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.14"
    }
  }
}

### INSTANCE


resource "libvirt_domain" "domain" {
  for_each  = toset(var.hostnames)
  name      = "${var.project}-${var.instance}-${each.key}"
  memory    = var.ram * 1024
  vcpu      = var.cpu
  autostart = true
  cloudinit = libvirt_cloudinit_disk.init[each.key].id

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

  dynamic "network_interface" {
      for_each = toset(var.net)
      content {
        network_name   = network_interface.key != "external" ? network_interface.key : null
        addresses      = null
        wait_for_lease = network_interface.key != "external" ? true : null
        macvtap        = network_interface.key == "external" ? "eno1" : null
    }
  }

  # Enable VNC on localhost address
  graphics {
    type        = "vnc"
    listen_type = "address"
  }
}

### CLOUD-INIT


data "template_cloudinit_config" "config" {
  for_each      = toset(var.hostnames)
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.root}/../config/cloud-init.yaml",
      { HOSTNAME = "${var.project}-${var.instance}-${each.key}"}
    )
  }

  part {
    content_type = "text/plain"
    content = templatefile("${path.root}/../config/noop.sh",
    { VERSION = "v1.0" })
  }
}

resource "libvirt_cloudinit_disk" "init" {
  for_each  = toset(var.hostnames)
  name      = "${var.project}-${var.instance}-${each.key}-init.iso"
  pool      = var.storage
  user_data = data.template_cloudinit_config.config[each.key].rendered
}


### VOLUME

# INFO: size parameters is in bytes : 1Go(fr) = 1GB(en) = 1.074e+9 bytes = 1Gb * 8
resource "libvirt_volume" "volume" {
  for_each       = toset(var.hostnames)
  name           = "${var.project}-${var.instance}-${each.key}-volume"
  base_volume_id = var.image_id
  pool           = var.storage
  size           = var.volume_size * 1.074e+9
}
