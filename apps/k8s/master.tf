
module "master" {
  source      = "../../modules/instance"
  project     = var.project
  instance    = var.master_instance
  hostnames   = var.master_hostnames
  ram         = var.master_ram
  cpu         = var.master_cpu
  volume_size = var.master_volume_size
  domain      = [module.network.domain]
  storage     = module.storage.pool
  image_id    = module.storage.image_id
  app_env     = { "TOKEN" = "L6wEUEn0FvHLrB5tExFv8JtGjrnxfFh6" , "MASTER_IP" = ""}
  app_script  = "kube.sh"
  depends_on = [
    module.network,
    module.storage
  ]
}

# Instance module


variable "master_instance" {
  type    = string
  default = "master"
}

variable "master_hostnames" {
  type    = list(any)
  default = ["0"]
}

variable "master_ram" {
  type    = number
  default = 4
}
variable "master_cpu" {
  type    = number
  default = 2
}
variable "master_volume_size" {
  type    = number
  default = 10
}