output "vpc_properties" {
  description = "List of basic VPC Properties"
  value = tomap({
    arn                                  = aws_vpc.main.arn
    default_network_acl_id               = aws_vpc.main.default_network_acl_id
    default_route_table_id               = aws_vpc.main.default_route_table_id
    default_security_group_id            = aws_vpc.main.default_security_group_id
    id                                   = aws_vpc.main.id
    ipv6_association_id                  = aws_vpc.main.ipv6_association_id
    ipv6_cidr_block_network_border_group = aws_vpc.main.ipv6_cidr_block_network_border_group
    main_route_table_id                  = aws_vpc.main.main_route_table_id
    owner_id                             = aws_vpc.main.owner_id
  })
}

output "public_subnets_properties" {
  description = "List of basic Public Subnets Properties"
  value = tomap({
    for k, subnet in aws_subnet.public : k => {
      arn = subnet.arn
      id  = subnet.id
    }
  })
}

output "private_subnets_properties" {
  description = "List of basic Private Subnets Properties"
  value = tomap({
    for k, subnet in aws_subnet.private : k => {
      arn = subnet.arn
      id  = subnet.id
    }
  })
}

output "database_subnets_properties" {
  description = "List of all* Database Subnets Properties"
  value = tomap({
    for k, subnet in aws_subnet.database : k => {
      arn = subnet.arn
      id  = subnet.id
    }
  })
}

output "database_subnet_group_properties" {
  description = "List of all* Database Subnet Group Properties"
  value = tomap({
    arn    = aws_db_subnet_group.default.arn
    id     = aws_db_subnet_group.default.id
    vpc_id = aws_db_subnet_group.default.vpc_id
  })
}
