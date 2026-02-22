# Create DB subnet groups 

resource "aws_db_subnet_group" "db_subnet" {
  name       = "rds-subnetsg"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}


# Create DB Instance: 

resource "aws_db_instance" "portfolio_db" {
  allocated_storage    = 10
  db_name              = "portfolio-db"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_pass
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids = [var.db_sg_id]
  publicly_accessible = false
}


