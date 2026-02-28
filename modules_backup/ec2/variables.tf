variable "vpc_id" {
  description = "VPC ID passed from the VPC module"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "The security group ID for the ALB"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security group ID for the EC2 instances"
  type        = string
}