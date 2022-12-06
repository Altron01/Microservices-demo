variable "vpc_name" {
  default = "vpc-demo"
}

variable "vpc_cidr" {
  default = "172.16.0.0/24"
}

variable "subnet_name" {
  default = "subent-demo"
}

variable "subnet_cidr" {
  default = "172.16.10.0/24"
}

variable "subnet_gateway" {
  default = "172.16.10.1"
}

variable "primary_dns" {
  default = "100.125.1.250"
}