# Provider Requirement: How to declare providers so Terraform can install them

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

# Provider Configuration: configure the AWS provider

provider "aws" {
  region = "ap-southeast-1"
}

# Import modules

module "vpc" {
  source                        = "./modules/VPC"
  cidr_block_from_variable_file = var.cidr
}

module "subnet" {
  source                         = "./modules/Subnet"
  vpc_id_from_vpc_module = module.vpc.vpc_id_from_vpc_module
  cidr_subnet_from_variable_file = var.cidr_subnet1
}
