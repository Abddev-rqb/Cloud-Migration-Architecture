variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR for public subnet"
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR for private subnet"
}

variable "aws_region" {
  type        = string
}

variable "private_subnet_cidr_2" {
  type = string
}