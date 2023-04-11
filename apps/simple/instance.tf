
module "instance" {
  source      = "../../modules/instance"
  project     = var.project
  instance    = var.instance
  hostnames   = var.hostnames
  ram         = var.ram
  cpu         = var.cpu
  volume_size = var.volume_size
  domain      = [module.network.domain, "external"]
  storage     = module.storage.pool
  image_id    = module.storage.image_id
  app_script  = "nohup.sh"
  app_env     = {}
  depends_on = [
    module.network,
    module.storage
  ]
}

# Instance module


variable "instance" {
  type    = string
  default = "worker"
}

variable "hostnames" {
  type    = list(any)
  default = ["0"]
}

variable "ram" {
  type    = number
  default = 4
}
variable "cpu" {
  type    = number
  default = 2
}
variable "volume_size" {
  type    = number
  default = 10
}

output "ips" {
  value = module.instance.ips
}