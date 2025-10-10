output "dns_name_development" {
    value = module.env_dev.dns_name
}

output "dns_name_production" {
    value = module.env_prod.dns_name
}