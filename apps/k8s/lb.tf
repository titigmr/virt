
module "lb" {
  source      = "../modules/instance"
  project     = var.project
  instance    = var.lb_instance
  hostnames   = var.lb_hostnames
  ram         = var.lb_ram
  cpu         = var.lb_cpu
  volume_size = var.lb_volume_size
  domain      = [module.network.domain, "external"]
  storage     = module.storage.pool
  image_id    = module.storage.image_id
  app_script  = var.lb_app_script
  depends_on = [
    module.network,
    module.storage
  ]
}

# Instance module


variable "lb_instance" {
  type    = string
  default = "lb"
}

variable "lb_hostnames" {
  type    = list(any)
  default = ["app"]
}

variable "lb_ram" {
  type    = number
  default = 2
}
variable "lb_cpu" {
  type    = number
  default = 2
}
variable "lb_volume_size" {
  type    = number
  default = 10
}

variable "lb_app_script" {}