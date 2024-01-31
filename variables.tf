# VPC Variables

variable "aws-region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "main_vpc_cidr" {
  description = "CIDR range for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "public subnet range"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "private subnet range"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  type        = list(string)
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}


variable "access_key" {
  default = "AKIA6F6U**********"
}

variable "secret_key" {
  default = "jUd5C7KNe2L40sKt***************"
}

variable "awspath" {
  default = "C:\\Program Files\\Amazon\\AWSCLIV2"
}

