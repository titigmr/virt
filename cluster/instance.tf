
module "worker" {
  source      = "../modules/instance"
  hostname    = var.hostname
  number_host = var.number_host
  ram         = var.ram
  cpu         = var.cpu
  volume_size = var.volume_size
  net         = module.base.net
  pool        = module.base.pool
  image_id    = module.base.image_id
  entries     = module.base.entries
  depends_on = [
    module.base
  ]
}