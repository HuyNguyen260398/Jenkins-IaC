# Provision VPC resource

resource "aws_vpc" "TerraformLab-VPC" {
  cidr_block = var.cidr_block_from_variable_file

  tags = {
    Name = "TerraformLab-VPC"
  }
}