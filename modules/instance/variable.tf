variable "project" {}
variable "instance" {}
variable "hostnames" {}

variable "ram" {}
variable "cpu" {}
variable "volume_size" {}
variable "image_id" {}

variable "env" {
    default = {}
}
variable "app_env" {
    default = {}
}
variable "app_script" {
    default = "nohup.sh"
}

variable "domain" {}
variable "storage" {}


