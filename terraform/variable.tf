variable "demo_name" {
    default = "demo"
}

variable "vpc_name" {
  default = "demo"
}

variable "vpc_cidr" {
  default = "172.16.0.0/24"
}

variable "subnet_name" {
  default = "subnet-demo"
}

variable "subnet_cidr" {
  default = "172.16.0.0/24"
}

variable "subnet_gateway" {
  default = "172.16.0.1"
}

variable "primary_dns" {
  default = "100.125.1.250"
}