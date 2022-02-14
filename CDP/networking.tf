resource "aws_vpc" "cdp_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "[CDP] VPC"
  }
}

resource "aws_internet_gateway" "to_Internet" {
  vpc_id = aws_vpc.cdp_vpc.id

  tags = {
    Name = "[CDP] Internet Gateway"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.cdp_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.to_Internet]

  tags = {
    Name = "[CDP] Public Subnet",
  }
}

resource "aws_route_table" "to_Internet" {
  vpc_id = aws_vpc.cdp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.to_Internet.id
  }

  tags = {
    Name = "[CDP] Public Route Table"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.to_Internet.id
}

resource "aws_subnet" "db_subnet_a" {
  vpc_id            = aws_vpc.cdp_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.11.0/24"

  tags = {
    Name = "[CDP] DB Subnet A"
  }
}

resource "aws_subnet" "db_subnet_b" {
  vpc_id            = aws_vpc.cdp_vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "10.0.21.0/24"

  tags = {
    Name = "[CDP] DB Subnet B"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "cdp_db_subnet_group"
  subnet_ids = [aws_subnet.db_subnet_a.id, aws_subnet.db_subnet_b.id]
}
