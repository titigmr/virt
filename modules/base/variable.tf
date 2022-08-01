
variable "pool" {
  default = "cluster"
}

variable "hostname" {
  type = string
}

variable "number_host" {
  type = number
}

variable "net" {
  default = "default"
}

variable "net_config" {
  type = map(any)
  default = {
    net_mode         = "nat",
    enable_dhcp      = true,
    enable_local_dns = true,
    cidr             = "10.0.3.0/24"
  }
  description = "mode can be: 'nat' (default), 'none', 'route', 'open', 'bridge'"
  nullable    = true
}