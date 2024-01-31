variable "vpc" {
  description = "VPC for Appserver"
}
variable "private_subnets"{
  description  = "Private Subnets for AppServer"
  type         = string
}
variable "ami_type" {
  default = "ami-0a0f1259dd1c90938"
}
variable "instance_name" {
  default = "AppServer"
}
variable "instance_type" {
  default = "m5.xlarge"
}

variable "capacity_type" {
  default = "ON_DEMAND"
}

variable "disk_size" {
  default = 50
}
