
module "worker" {
  source      = "../modules/instance"
  hostname    = var.hostname
  number_host = var.number_host
  ram         = var.ram
  cpu         = var.cpu
#  ip          = var.ip
  volume_size = var.volume_size
  image_id    = module.base.image_id
  pool        = var.pool

  depends_on = [
    module.base
  ]
}