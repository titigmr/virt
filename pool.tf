 resource "libvirt_pool" "pool" {
   name = "${var.pool}"
   type = "dir"
   path = "/var/opt/vm/${var.pool}_storage"
}