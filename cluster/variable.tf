
# Instance module

variable "hostname" {
  type = string
  default = "worker"
}
variable "number_host" {
  type = number
  default = 2
}

variable "ram" {
  type = number
  default = 4
}
variable "cpu" {
  type = number
  default = 2
}
variable "volume_size" {
  type = number
  default = 10
}

#variable "ip" { default = ["192.168.122.10"] }

# Base module

variable "pool" {
  default = "cluster"
}