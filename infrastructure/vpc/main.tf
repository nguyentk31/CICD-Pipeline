// Find All Availability Zones 
data "aws_availability_zones" "azs" {
  state = "available"

  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

// VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc1"
  }
}

// Public Subnets
resource "aws_subnet" "public-subnets" {
  count = var.number_public_subnets
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index % length(data.aws_availability_zones.azs)]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index+1}"
    "kubernetes.io/role/elb" = "1"
  }
}

// Private Subnets
resource "aws_subnet" "private-subnets" {
  count = var.number_private_subnets
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index+var.number_public_subnets)
  availability_zone = data.aws_availability_zones.azs.names[count.index % length(data.aws_availability_zones.azs)]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index+1}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

// Internet gateway, elastic ip, nat gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-internet-gateway"
  }
}

resource "aws_eip" "eip" {
  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnets[0].id // The first public subnet
  connectivity_type = "public"

  tags = {
    Name = "${var.vpc_name}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

// Route tables and associations
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }
}

resource "aws_route_table" "pri-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }
}

resource "aws_route_table_association" "pub-rt-association" {
  for_each       = { for k, v in aws_subnet.public-subnets : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pub-rt.id
}

resource "aws_route_table_association" "pri-rt-association" {
  for_each       = { for k, v in aws_subnet.private-subnets : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.pri-rt.id
}