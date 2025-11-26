provider "aws" {
  region = "us-east-1"
}


module "vpc_setup" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "WebServer" {
  source = "./modules/web_server"
  key_name = "ecommerse"
  subnet_id = module.vpc_setup.public_sn_id
  security_groups  = module.vpc_setup.ec2_sg_id
}
