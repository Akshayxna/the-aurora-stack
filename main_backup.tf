# Calling the Network Module

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = [ "10.0.1.0/24", "10.0.2.0/24" ] 
  
}


# Calling the Ec2 Module

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id = module.vpc.alb_sg_id
  ec2_sg_id  = module.vpc.ec2_sg_id
}


