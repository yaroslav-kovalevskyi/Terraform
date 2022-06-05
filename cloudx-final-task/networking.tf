resource "aws_vpc" "main" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.project
  }
}

resource "aws_subnet" "public" {
  count             = length(var.subnet_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.subnet_zones, count.index)

  tags = {
    Name = "public_${element(var.subnet_zones, count.index)}"
    Tier = "Public"
  }
}

resource "aws_subnet" "private" {
  count             = length(var.subnet_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.subnet_zones, count.index)

  tags = {
    Name = "private_${element(var.subnet_zones, count.index)}"
    Tier = "Private"
  }
}

resource "aws_subnet" "db" {
  count             = length(var.subnet_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.db_subnet_cidr, count.index)
  availability_zone = element(var.subnet_zones, count.index)

  tags = {
    Name = "private_db_${element(var.subnet_zones, count.index)}"
    Tier = "Private"
  }
}

resource "aws_internet_gateway" "to_Internet" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_route_table" "to_Internet" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.to_Internet.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public-internet" {
  count          = length(var.subnet_zones)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.to_Internet.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.subnet_zones)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private-db" {
  count          = length(var.subnet_zones)
  subnet_id      = element(aws_subnet.db.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "ghost"
  subnet_ids = aws_subnet.db.*.id
  tags = {
    Name = "${var.project} DB Subnet Group"
  }
}
