output "ips" {
  value = libvirt_domain.domain.*.network_interface.0.addresses
}