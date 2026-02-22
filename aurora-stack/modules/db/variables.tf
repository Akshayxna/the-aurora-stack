variable "private_subnet_ids" {
    type = list(string)
  
}

variable "db-pass" {
    type = string
    sensitive = true
}

variable "db_sg_id" {
    type = string
  
}

variable "db_username" {
    type = string
}