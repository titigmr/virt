output "image_id" {
  value = libvirt_volume.image.id
}

output "pool" {
  value = var.pool
}