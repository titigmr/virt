
module "worker" {
  source      = "../../modules/instance"
  project     = var.project
  instance    = var.worker_instance
  hostnames   = var.worker_hostnames
  ram         = var.worker_ram
  cpu         = var.worker_cpu
  volume_size = var.worker_volume_size
  domain      = [module.network.domain]
  storage     = module.storage.pool
  image_id    = module.storage.image_id
  depends_on = [
    module.network,
    module.storage
  ]
}

# Instance module


variable "worker_instance" {
  type    = string
  default = "worker"
}

variable "worker_hostnames" {
  type    = list(any)
  default = ["0"]
}

variable "worker_ram" {
  type    = number
  default = 4
}
variable "worker_cpu" {
  type    = number
  default = 2
}
variable "worker_volume_size" {
  type    = number
  default = 10
}