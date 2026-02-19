resource "aws_security_group" "web_sg" {
    name = "${var.project_name}-web-sg"
    description = "Allow HTTP and HTTPS traffic"
    vpc_id = var.vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
   
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_instance" "web_server" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.web_sg.id]

    user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              echo "<h1>Deployed via Terraform!</h1>" > /var/www/html/index.html
              EOF

    tags = {
        Name = "${var.project_name}-web-instance"
    }
}