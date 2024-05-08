# vpc
resource "aws_vpc" "ibm-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ibm"
  }
}

# public subnet
resource "aws_subnet" "ibm-web-sn" {
  vpc_id     = aws_vpc.ibm-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "ibm-web-subnet"
  }
}

# Private subnet
resource "aws_subnet" "ibm-data-sn" {
  vpc_id     = aws_vpc.ibm-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "ibm-database-subnet"
  }
}

# Internet gateway
resource "aws_internet_gateway" "ibm-igw" {
  vpc_id = aws_vpc.ibm-vpc.id

  tags = {
    Name = "ibm-internet-gateway"
  }
}

# Public Route Table
resource "aws_route_table" "ibm-web-rt" {
  vpc_id = aws_vpc.ibm-vpc.id

  route {
    cidr_block = "0.0.0.0/00"
    gateway_id = aws_internet_gateway.ibm-igw.id
  }

  tags = {
    Name = "ibm-web-route-table"
  }
}

# Public route table association
resource "aws_route_table_association" "ibm-web-rt-association" {
  subnet_id      = aws_subnet.ibm-web-sn.id
  route_table_id = aws_route_table.ibm-web-rt.id
}