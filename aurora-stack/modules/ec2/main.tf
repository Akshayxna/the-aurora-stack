
# Create LoadBalancer 

resource "aws_lb" "portfolio-alb" {
  name                       = "portfolio-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_sg_id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = false


  tags = {
    Environment = "portfolio-alb"
  }
}

# Create TargetGroup

resource "aws_lb_target_group" "Portfolio_tg" {
  name     = "Portfolio-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"   # The page AWS will ping (index.html)
    interval            = 30    # How often to check (seconds)
    timeout             = 5     # How long to wait for a response
    healthy_threshold   = 2     # Successes needed to be "Healthy"
    unhealthy_threshold = 2     # Failures needed to be "Unhealthy"
    matcher             = "200" # The HTTP code that means "OK"
  }
}


# Create Listner 

resource "aws_lb_listener" "Port_listner" {
  load_balancer_arn = aws_lb.portfolio-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Portfolio_tg.arn
  }
}


# Create AWS Instances 

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (the creators of Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "ec2_instance" {
  count                  = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.ec2_sg_id]
  subnet_id              = var.subnet_ids[count.index]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "Portfolio-${count.index + 1}"
  }
}

# Register usieng Target grp attachment 

resource "aws_lb_target_group_attachment" "portfolio_attach" {
  count = 2
  target_group_arn = aws_lb_target_group.Portfolio_tg.arn
  target_id        = aws_instance.ec2_instance[count.index].id
  port             = 80
}




