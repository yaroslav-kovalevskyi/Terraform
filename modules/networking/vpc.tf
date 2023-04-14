######################### VPCs #########################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "[${var.environment}] Main VPC"
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
    Name = "[${var.environment}] Public Subnet"
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
    Name = "[${var.environment}] Private Subnet"
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
    Name = "[${var.environment}] Database Subnet"
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
    Name = "[${var.environment}] Route Table to Internet"
  }
}

resource "aws_route_table_association" "public-internet" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.to_Internet.id
}

######################### Internet Gateway #########################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "[${var.environment}] Internet Gateway"
  }
}

######################### Security Groups #########################
