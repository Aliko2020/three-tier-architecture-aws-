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

module "rds_setup" {
  source = "./modules/rds"

  db_subnet_group_name   = module.vpc_setup.rds_subnet_group_name  
  rds_security_group_ids = [module.vpc_setup.rds_sg_id]          
  db_password            = var.db_password
}

module "s3_hosting" {
  source = "./modules/s3"
  bucket_name    = "my-react-website-12345"
  
}