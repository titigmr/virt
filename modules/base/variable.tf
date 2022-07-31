
variable "pool" {
  default = "cluster"
}

variable "hostname" {
    type =  string
}

variable "number_host" {
    type = number
}

variable "net_mode" {
    type = string
    default = "nat"
    description = "mode can be: 'nat' (default), 'none', 'route', 'open', 'bridge'"
}

variable "enable_dhcp" {
    type = bool
    default = false
}

variable "enable_local_dns" {
    type = bool
    default = false
}

variable "cidr" {
    default = "10.0.3.0/24"
}