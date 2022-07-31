
# Instance module

variable "hostname" {
  default = "worker-1"
}
variable "ram" {
  default = 4
}
variable "cpu" {
  default = 2
}
variable "volume_size" {
  default = 10
}

# Base module

variable "pool" {
  default = "cluster"
}