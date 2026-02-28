
variable "aws_region"{
      description = "The region where the server is created"
      type = string
      default = "aws-east-1" 
}

variable "instance_type" {
      description = "size of the disk used"
      type = string
      default = "t2.micro"
}

variable "project_name" {
      description = "name of the tagging resources"
      type = string
}

variable "ingress_ports" {
      description = "List the ports to open"
      type = list(number)
      default = [80,22,443]
}
