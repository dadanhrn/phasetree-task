output "dns_name_development" {
    description = "DNS name for development environment"
    value = module.env_dev.dns_name
}

output "dns_name_production" {
    description = "DNS name for production environment"
    value = module.env_prod.dns_name
}