provider "aws" {
  region = "us-east-1"
}


module "my-networking" {
  source = "/root/devops-lab/modules/networking"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
  project_name = "my-web-project"
  availability_zone = "us-east-1a"
}

module "my-compute" {
  source = "/root/devops-lab/modules/compute"
  subnet_id = module.my-networking.public_subnet_id
  vpc_id = module.my-networking.vpc_id
  project_name = "my-web-project"
  
}

output "server_public_ip" {
  description = "The public IP of our web server"
  value       = module.my-compute.instance_public_ip
}