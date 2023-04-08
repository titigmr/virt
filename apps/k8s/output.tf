output "ips_worker" {
  value = module.worker.ips
}

output "ips_master" {
  value = module.master.ips
}

output "ips_lb" {
  value = module.lb.ips
}