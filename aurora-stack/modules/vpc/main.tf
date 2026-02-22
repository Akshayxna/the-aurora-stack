# Created VPC

resource "aws_vpc" "portfolio_vpc" {
  cidr_block = var.vpc_cidr
}


# Created Internet Gateway 

resource "aws_internet_gateway" "portfolio_gw" {
  vpc_id = aws_vpc.portfolio_vpc.id

  tags = {
    Name = "Port_gateway"
  }
}


# Create the PUBLIC subnets 

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.portfolio_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "portfolio_subnet_1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.portfolio_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "portfolio_subnet_2"
  }
}

# Create PRIVATE subnets 

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.portfolio_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "portfolio_prv_subnet_1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.portfolio_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zone[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "portfolio_prv_subnet_2"
  }
}

# Created the Route Table

resource "aws_route_table" "port_route" {
  vpc_id = aws_vpc.portfolio_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.portfolio_gw.id
  }

  tags = {
    Name = "portfolio-public-rt"
  }
}


# Route table association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.port_route.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.port_route.id
}
