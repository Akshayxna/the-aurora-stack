variable "vpc_cidr" {
    default = "10.0.0.0/16"  
}

variable "availability_zone" {
    type = list(string)
    default = [ "ap-south-1a", "ap-south-1b" ]
}


variable "subnet_cidr" {
    type = list(string)
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]  
}
