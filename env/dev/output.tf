output "rds_endpoint" {
  value = module.database.rds_endpoint
}

output "rds_port" {
  value = module.database.rds_port
}

output "onprem_public_ip" {
  value = module.compute.onprem_public_ip
}