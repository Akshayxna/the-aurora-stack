
# Creating an EC2 Instance
resource "aws_instance" "akshay_ec2" {
  instance_type = "t2.micro"
  ami           = data.aws_ami.ubuntu.id
  availability_zone = "us-east-1a"

  primary_network_interface {
    network_interface_id = aws_network_interface.ec2_net.id
  }

  
  user_data = <<-EOF
            #!/bin/bash
            # 1. Wait for system locks to release
            while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do sleep 5; done
            
            # 2. Update and Install
            apt-get update -y
            apt-get install -y apache2
            
            # 3. Start and Enable
            systemctl start apache2
            systemctl enable apache2
            
            # 4. Create index (Using double quotes to avoid 'Akshay's' quote error)
            echo "<h1>Welcome to Akshays Web Server</h1>" > /var/www/html/index.html
            EOF

    tags = {
    Name = "Akshay-server"
  }
}

# Create a custom VPC

resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "ubuntu_vpc"
  }
}

# Create  an Internet Gateway

resource "aws_internet_gateway" "my_gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "ubuntu_gateway"
  }
}

# Create a Route Table

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"   # Making it a deafult route
    gateway_id = aws_internet_gateway.my_gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.my_gw.id
  }

  tags = {
    Name = "Routetab"
  }
}

# Create a Subnet

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "ubuntu-sub"
  }
}


# Associate Route table with Subnet 

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}


# Create a security Group

resource "aws_security_group" "ec2_sg" {
  name        = "allow_web_traffic_v2" # Changed name to avoid conflicts
  description = "Allow port 80"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "HTTP"
    from_port   = var.ingress_ports[0]
    to_port     = var.ingress_ports[0]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = var.ingress_ports[1]
    to_port     = var.ingress_ports[1]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = var.ingress_ports[2]
    to_port     = var.ingress_ports[2]
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}


# Create Network Interface with an IP with an IP in the subnet

resource "aws_network_interface" "ec2_net" {
  subnet_id       = aws_subnet.my_subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.ec2_sg.id]

}


# assigned a public IP instead of eip:


resource "aws_eip" "ec2_ip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.ec2_net.id
  associate_with_private_ip = "10.0.1.50"
  depends_on                = [aws_internet_gateway.my_gw]
}


output "final_public_ip" {
  value = [aws_eip.ec2_ip.public_ip, aws_instance.akshay_ec2]
}



