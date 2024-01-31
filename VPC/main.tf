##VPC Creation
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.main_vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "Test-VPC"
  }
}

##Public Subnet Creation
resource "aws_subnet" "public_subs" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Test-VPC-PublicSubnet-${count.index + 1}"
    env  = "Public"
  }
  depends_on = [
    aws_vpc.main_vpc,
  ]
}

##Private Subnet Creation
resource "aws_subnet" "private_subs" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  tags = {
    Name = "Test-VPC-PrivateSubnet-${count.index + 1}"
    env  = "Private"
  }
}

##Internet Gateway Setup
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id #We associated this IG with the VPC we created before by specifying the VPC id attribute

  tags = {
    Name = "Test-VPC-IGW"
  }
}

##EIP for NAT Gateway
resource "aws_eip" "nat_eip" {
    tags = {
    Name = "Nat-GW-eip"
  }
}

##NAT Gateway Creation
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subs.*.id,1)

  tags = {
    Name = "Test-VPC-NGW"
  }
  depends_on = [aws_internet_gateway.gw, aws_eip.nat_eip, aws_subnet.private_subs ]
}

##Secondary Route Table Creation
resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Test-VPC-Public-RT"
  }
  depends_on = [aws_internet_gateway.gw, aws_vpc.main_vpc, aws_subnet.public_subs ]
}

##Route Table for Private Subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "Test-VPC-Private-RT"
  }
  depends_on = [aws_nat_gateway.ngw, aws_vpc.main_vpc, aws_subnet.private_subs ]
}


##Associate Public Subnets with the Second Route Table
resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subs[*].id, count.index)
  route_table_id = aws_route_table.second_rt.id
}

##Associate Private Subnets with the Private Route Table
resource "aws_route_table_association" "private_subnet_asso" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subs[*].id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

