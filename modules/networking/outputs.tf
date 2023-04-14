output "VPC_ID" {
  description = "Provide VPC ID"
  value       = aws_vpc.main.id
}

output "VPC_ARN" {
  description = "Provide VPC ARN"
  value       = aws_vpc.main.arn
}

output "Public_Subnet_IDs" {
  description = "Provide all Public Subnets IDs"
  value       = aws_subnet.public.*.id
}

output "Public_Subnet_ARNs" {
  description = "Provide all Public Subnets IDs"
  value       = aws_subnet.public.*.arn
}
output "Private_Subnet_IDs" {
  description = "Provide all Private Subnets IDs"
  value       = aws_subnet.private.*.id
}

output "Private_Subnet_ARNs" {
  description = "Provide all Private Subnets IDs"
  value       = aws_subnet.private.*.arn
}

output "Database_Subnet_IDs" {
  description = "Provide all Database Subnets IDs"
  value       = aws_subnet.database.*.id
}

output "Database_Subnet_ARNs" {
  description = "Provide all Database Subnets IDs"
  value       = aws_subnet.database.*.arn
}
