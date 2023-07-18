terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "EC2" {
  ami           = "ami-06ca3ca175f37dd66"
  instance_type = "t2.micro"

  tags = {
    Name = "EC2"
  }
}

resource "aws_eip" "EIP" {
  instance = aws_instance.EC2.id
  vpc      = true

  tags = {
    Name = "EIP"
  }
}