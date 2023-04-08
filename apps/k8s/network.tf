module "network" {
  source           = "../../modules/network"
  domain           = var.network_domain
  net_mode         = var.network_net_mode
  enable_dhcp      = var.network_enable_dhcp
  enable_local_dns = var.network_enable_local_dns
  cidr             = var.network_cidr
}

variable "network_domain" {
  default = "k8s"
  description = "choose a name, or `external` for macvtap network"
}

variable "network_net_mode" {
  default     = "nat"
  description = "mode can be: 'nat' (default), 'none', 'route', 'open', 'bridge'"
}

variable "network_enable_dhcp" {
  default = true
}

variable "network_enable_local_dns" {
  default = true
}

variable "network_cidr" {
  default = "10.0.3.0/24"
}

