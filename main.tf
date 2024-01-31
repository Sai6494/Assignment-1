provider "aws" {
  region = "ap-south-1"
  access_key=var.access_key
  secret_key=var.secret_key
}

terraform {
  backend "s3" {
    bucket         = "awssampletestbucket"
    key            = "./terraform.tfstate"
    region         = "ap-south-1"  
    encrypt        = true
    #dynamodb_table = "terraform-lock-table"
  }
}

module "VPC" {
  source = "./VPC"
}

module "Webserver" {
  source         = "./Webserver"
  vpc            = module.VPC.vpc_id
  public_subnets = module.VPC.public_subs_id[0]
  depends_on     = [module.VPC]
}

module "AppServer" {
  source          = "./AppServer"
  vpc             = module.VPC.vpc_id
  private_subnets  = module.VPC.private_subs_id[0]
  depends_on     = [module.VPC]
}

module "RDS" {
  source          = "./RDS"
  vpc             = module.VPC.vpc_id
  private_subnet  = module.VPC.private_subs_id
  depends_on     = [module.VPC]
}