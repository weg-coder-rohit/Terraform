# VPC Created Below
resource "aws_vpc" "Terra_first_vpc" {
  cidr_block           = var.CIDR
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "First_VPC_with_Terraform"
  }
}

# 3 Public Subnets Creates Below
resource "aws_subnet" "PUBSUB1" {
  vpc_id                  = aws_vpc.Terra_first_vpc.id
  cidr_block              = var.PUBSUB1
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "PUBSUB1"
  }
}

resource "aws_subnet" "PUBSUB2" {
  vpc_id                  = aws_vpc.Terra_first_vpc.id
  cidr_block              = var.PUBSUB2
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "PUBSUB2"
  }
}

resource "aws_subnet" "PUBSUB3" {
  vpc_id                  = aws_vpc.Terra_first_vpc.id
  cidr_block              = var.PUBSUB3
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "PUBSUB3"
  }
}

# 3 Private Subnet Created below

resource "aws_subnet" "PRIVSUB1" {
  vpc_id                  = aws_vpc.Terra_first_vpc.id
  cidr_block              = var.PRIVSUB1
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "PRIVSUB1"
  }
}

resource "aws_subnet" "PRIVSUB2" {
  vpc_id                  = aws_vpc.Terra_first_vpc.id
  cidr_block              = var.PRIVSUB2
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "PRIVSUB2"
  }
}

resource "aws_subnet" "PRIVSUB3" {
  vpc_id                  = aws_vpc.Terra_first_vpc.id
  cidr_block              = var.PRIVSUB3
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "PRIVSUB3"
  }
}

# Internet Created below
resource "aws_internet_gateway" "Terra_first_IGW" {
  vpc_id = aws_vpc.Terra_first_vpc.id
  tags = {
    Name = "First_VPC_IGW"
  }
}

# Route Table

resource "aws_route_table" "Terra_first_VPC_routetable" {
  vpc_id = aws_vpc.Terra_first_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terra_first_IGW.id
  }
  tags = {
    Name = "Terra_First_VPC_routetable"
  }

}

resource "aws_route_table_association" "terraroute_table_association1" {
  subnet_id      = aws_subnet.PUBSUB1.id
  route_table_id = aws_route_table.Terra_first_VPC_routetable.id
}

resource "aws_route_table_association" "terraroute_table_associatio2" {
  subnet_id      = aws_subnet.PUBSUB2.id
  route_table_id = aws_route_table.Terra_first_VPC_routetable.id
}

resource "aws_route_table_association" "terraroute_table_association3" {
  subnet_id      = aws_subnet.PUBSUB3.id
  route_table_id = aws_route_table.Terra_first_VPC_routetable.id
}


resource "aws_route_table_association" "terraroute_table_association4" {
  subnet_id      = aws_subnet.PRIVSUB1.id
  route_table_id = aws_route_table.Terra_first_VPC_routetable.id
}