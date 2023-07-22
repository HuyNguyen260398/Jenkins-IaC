variable "cidr_block" {
  type = list(string)
  default = [ "170.20.0.0/16", "170.20.10.0/24" ]
}

variable "ports" {
  type = list(number)
  default = [ 22, 80, 443, 8080, 8081 ]
}

variable "ami" {
  type = string
  default = "ami-06b79cf2aee0d5c92"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}