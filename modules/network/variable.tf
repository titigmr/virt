variable "net" {
  default = "default"
}

variable "net_mode" {
  default = "nat"
  description = "mode can be: 'nat' (default), 'none', 'route', 'open', 'bridge'"
}

variable "enable_dhcp" {
  default = true
}

variable "enable_local_dns" {
  default = true
}

variable "cidr" {
  default = "10.0.3.0/24"
}


