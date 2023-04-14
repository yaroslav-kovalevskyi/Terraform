output "VPC_ID" {
  description = "Provide VPC ID"
  value       = aws_vpc.main.id
}

output "Public_Subnet_ID" {
  description = "Provide all Public Subnets IDs"
  value       = aws_subnet.public.*.id
}

output "Private_Subnet_ID" {
  description = "Provide all Private Subnets IDs"
  value       = aws_subnet.private.*.id
}

output "Database_Subnet_ID" {
  description = "Provide all Database Subnets IDs"
  value       = aws_subnet.database.*.id
}
