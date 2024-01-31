variable "vpc" {
  description = "Public Subnets for Webserver"
}
variable "public_subnets"{
  description  = "Public Subnets for Webserver"
}
variable "ami_type" {
  default = "ami-0a0f1259dd1c90938"
}
variable "Webserver_name" {
  default = "Webserver_Host"
}
variable "instance_type" {
  default = "m5.large"
}

variable "capacity_type" {
  default = "ON_DEMAND"
}

variable "disk_size" {
  default = 8
}