
module "base" {
  source = "../modules/base"
  pool   = var.pool
  number_host = var.number_host
  hostname = var.hostname
}