variable "cidr" {
  // arguments
  type        = string
  description = "This is a variable"
}

# String

variable "vpc_name" {
  type = string
}

# Number

variable "vpc_number" {
  type = number
}

# Boolean

variable "vpc_exists" {
  type = bool
}

# List

variable "vpc_list" {
  type = list(string)
}

# Tupple

variable "vpc_tuple" {
  type = tuple([string, number, string])
}

# Map

variable "vpc_map" {
  type = map(any)
}

# Object

variable "vpc_object" {
  type = object({
    Key1 = string,
    Key2 = number
  })
}
