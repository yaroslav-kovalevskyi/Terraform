resource "aws_internet_gateway" "Internet_GW" {
  vpc_id = aws_vpc.Nextcloud_plus_DB

  tags = {
    Name = "Nextcloud + DB gateway"
  }
}

resource "aws_subnet" "Private_Subnet" {
  vpc_id     = aws_vpc.Nextcloud_plus_DB.id
  cidr_block = "10.0.12.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Private Subnet for DB"
  }
}

resource "aws_subnet" "Public_Subnet" {
  vpc_id     = aws_vpc.Nextcloud_plus_DB.id
  cidr_block = "10.0.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "Public Subnet"
  }
}