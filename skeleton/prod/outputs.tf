
output "region" {
  description = "AWS region"
  value       = var.region
}

output "vpc_id" {
  description = "vpc_id"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "public_subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "private_subnets"
  value       = module.vpc.private_subnets
}

output "private_route_table" {
  description = "private_route_table"
  value       = module.vpc.private_route_table_ids
}

output "public_route_table" {
  description = "public_route_table"
  value       = module.vpc.public_route_table_ids
}
