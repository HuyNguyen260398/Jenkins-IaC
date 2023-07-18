resource "aws_subnet" "TerraformLab-Subnet1" {
  vpc_id     = var.vpc_id_from_vpc_module
  cidr_block = var.cidr_subnet_from_variable_file

  tags = {
    Name = "TerraformLab-Subnet1"
  }
}