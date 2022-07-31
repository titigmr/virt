
module "instance" {
  source      = "../modules/instance"
  hostname    = var.hostname
  ram         = var.ram
  cpu         = var.cpu
  volume_size = var.volume_size
  image_id    = module.base.image_id
  pool        = var.pool

  depends_on = [
    module.base
  ]
}