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
  access_key = "AKIAQE2WXIOJC57EH6UF"
  secret_key = "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"
}

# Provision VPC resource

resource "aws_vpc" "Terraform-VPC" {
  cidr_block = var.cidr

  tags = {
    Name = "Terraform-VPC"
    VPC_Name = var.vpc_name
    VPC_Exists = var.vpc_exists
    VPC_List = var.vpc_list[0]
    VPC_Map = var.vpc_map["Key1"]
    VPC_Tuple = var.vpc_tuple[1]
    VPC_Object = var.vpc_object["Key2"]
  }
}