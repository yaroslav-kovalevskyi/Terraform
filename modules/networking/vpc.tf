######################### VPCs #########################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment} | ${var.project} VPC"
  }
}

######################### Subnets #########################

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidr, count.index)
  availability_zone       = element(data.aws_availability_zones.in_current_region.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment} | ${var.project} Public Subnet"
    Tier = "Public"
  }
}

resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnet_cidr, count.index)
  availability_zone       = element(data.aws_availability_zones.in_current_region.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment} | ${var.project} Private Subnet"
    Tier = "Private"
  }
}

resource "aws_subnet" "database" {
  count                   = length(var.database_subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.database_subnet_cidr, count.index)
  availability_zone       = element(data.aws_availability_zones.in_current_region.names, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment} | ${var.project} Database Subnet"
    Tier = "Database"
  }
}

######################### Route Tables #########################

resource "aws_route_table" "to_Internet" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.environment} | ${var.project} Route Table to Internet"
  }
}

resource "aws_route_table_association" "to_Internet" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.to_Internet.id
}

# resource "aws_route_table" "nat" {
#   count  = var.nat_enabled ? 1 : 0
#   vpc_id = aws_vpc.main.id
#   route {
#     cidr_block     = "0.0.0.0/0"
#     nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
#   }
#   tags = {
#     Name = "${var.environment} | ${var.project} NAT Route Table"
#   }
# }

# resource "aws_route_table_association" "nat" {
#   count          = length(concat(var.database_subnet_cidr, var.private_subnet_cidr))
#   subnet_id      = element(concat(aws_subnet.database.*.id, aws_subnet.private.*.id), count.index)
#   route_table_id = aws_route_table.nat[count].id
# }


######################### Internet Gateway #########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.environment} | ${var.project} Internet Gateway"
  }
}

######################### NAT Gateway #########################

# resource "aws_eip" "nat_gateway" {
#   count  = var.nat_enabled ? 1 : 0
#   domain = "vpc"
# }

# resource "aws_nat_gateway" "nat_gateway" {
#   count         = var.nat_enabled ? 1 : 0
#   allocation_id = aws_eip.nat_gateway[count.index].id
#   subnet_id     = aws_subnet.public[0].id

#   tags = {
#     Name = "${var.environment} | ${var.project} NAT Gateway"
#   }

#   depends_on = [aws_internet_gateway.igw]
# }
