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
  default = "ami-0b94777c7d8bfe7e3"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}