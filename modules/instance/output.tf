
output "ips" {
  value = flatten([
    for ip in libvirt_domain.domain : ip.network_interface.*.addresses
  ])
}

output "ips" {
  value = flatten([
    for ip in libvirt_domain.domain : ip.network_interface.*.addresses
  ])
}