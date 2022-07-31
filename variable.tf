variable "hostname" {
    default = "worker-1"
}
variable "ip_type" {
    default = "dhcp"
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
variable "pool" {
    default = "cluster"
}