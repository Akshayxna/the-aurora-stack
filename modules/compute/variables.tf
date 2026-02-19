variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
  
}

variable "project_name" {
  description = "Name of the project for tagging resources"
  type        = string
  
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0c7217cdde317cfec" # Ubuntu 22.04 in us-east-1 (check yours!)
}
