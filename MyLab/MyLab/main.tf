terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

# Configure the AWS provider

provider "aws" {
  region = "ap-southeast-1"
}

# Create a VPC

resource "aws_vpc" "MyLab-VPC" {
  cidr_block = var.cidr_block[0]

  tags = {
    Name = "MyLab-VPC"
  }
}

# Create Subnet (Public)

resource "aws_subnet" "MyLab-Subnet1" {
  vpc_id     = aws_vpc.MyLab-VPC.id
  cidr_block = var.cidr_block[1]

  tags = {
    Name = "MyLab-Subnet1"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "MyLab-IntGw" {
  vpc_id = aws_vpc.MyLab-VPC.id

  tags = {
    Name = "MyLab-IntGw"
  }
}

# Create Secturity Group

resource "aws_security_group" "MyLab-Sec-Group" {
  name        = "MyLab Security Group"
  description = "To allow inbound and outbound traffic to mylab"
  vpc_id      = aws_vpc.MyLab-VPC.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # allow all trafics
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow traffic"
  }
}

# Create route table and association

resource "aws_route_table" "MyLab-RouteTable" {
  vpc_id = aws_vpc.MyLab-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyLab-IntGw.id
  }

  tags = {
    Name = "MyLab-RouteTable"
  }
}

resource "aws_route_table_association" "MyLab-Assn" {
  subnet_id      = aws_subnet.MyLab-Subnet1.id
  route_table_id = aws_route_table.MyLab-RouteTable.id
}

# Create an AWS EC2 Instance for Jenkins

# resource "aws_instance" "Jenkins" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name = "EC2"
#   vpc_security_group_ids = [aws_security_group.MyLab-Sec-Group.id]
#   subnet_id = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data = file("./InstallJenkins.sh")

#   tags = {
#     Name = "Jenkins-Server"
#   }
# }

# Create an AWS EC2 Instance to host Ansible Controller (Control node)

# resource "aws_instance" "Ansible-Controller" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name = "EC2"
#   vpc_security_group_ids = [aws_security_group.MyLab-Sec-Group.id]
#   subnet_id = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data = file("./InstallAnsibleCN.sh")

#   tags = {
#     Name = "Ansible-Control-Node"
#   }
# }

# Create an AWS EC2 Instance (Ansible Manage node 1) to host Apache Tomcat server

# resource "aws_instance" "Ansible-Manage-Node-1" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name = "EC2"
#   vpc_security_group_ids = [aws_security_group.MyLab-Sec-Group.id]
#   subnet_id = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data = file("./AnsibleManagedNode.sh")

#   tags = {
#     Name = "Ansible-Manage-Node-Apache-Tomcat"
#   }
# }

# Create an AWS EC2 Instance (Ansible Manage node 2) to host Docker

# resource "aws_instance" "Ansible-Manage-Node-2" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name = "EC2"
#   vpc_security_group_ids = [aws_security_group.MyLab-Sec-Group.id]
#   subnet_id = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data = file("./Docker.sh")

#   tags = {
#     Name = "Ansible-Manage-Node-Docker"
#   }
# }

# Create an AWS EC2 Instance to host Sonatype Nexus

# resource "aws_instance" "Nexus" {
#   ami           = var.ami
#   instance_type = var.instance_type_for_nexus
#   key_name = "EC2"
#   vpc_security_group_ids = [aws_security_group.MyLab-Sec-Group.id]
#   subnet_id = aws_subnet.MyLab-Subnet1.id
#   associate_public_ip_address = true
#   user_data = file("./InstallNexus.sh")

#   tags = {
#     Name = "Nexus-Server"
#   }
# }