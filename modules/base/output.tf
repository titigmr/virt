output "image_id" {
  value = libvirt_volume.image.id
}

output "pool" {
  value = var.pool
}

output "net" {
  value = var.net
}

output "entries" {
  value = local.entries
}