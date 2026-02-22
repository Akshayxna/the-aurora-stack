output "vpc_id" {
    value = aws_vpc.portfolio_vpc.id
  
}

output "public_subnet_ids" {
    value = [aws_subnet.public_1.id, aws_subnet.public_2.id]
  
}

output "private_subnet_ids" {
    value = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}

output "alb_sg_id" {
    value = aws_security_group.alb_sg.id
}

output "igw_id" {
    value = aws_internet_gateway.portfolio_gw.id
}

output "ec2_sg_id" {
  description = "The ID of the security group for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}

output "db_sg_id" {
   value =  aws_security_group.db_sg.id
  
}