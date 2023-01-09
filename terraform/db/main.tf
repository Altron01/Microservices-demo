terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
    }
  }
}

variable "demo_name" {}
variable "az" {}
variable "vpc_id" {}
variable "subnet_id" {}
variable "security_group_id" {}

resource "huaweicloud_rds_instance" "mysql-demo" {
  name                = "mysql-${var.demo_name}"
  flavor              = "rds.mysql.n1.large.4"
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  security_group_id   = var.security_group_id
  availability_zone   = var.az

  db {
    type     = "MySQL"
    version  = "8.0"
    password = var.rds_password
  }
  volume {
    type = "CLOUDSSD"
    size = 40
  }
}

data "huaweicloud_dcs_flavors" "single_flavors" {
  cache_mode = "single"
  capacity   = 0.125
}

resource "huaweicloud_dcs_instance" "dcs-demo" {
  name               = "dsc-${var.demo_name}"
  engine             = "Redis"
  engine_version     = "5.0"
  capacity           = data.huaweicloud_dcs_flavors.single_flavors.capacity
  flavor             = data.huaweicloud_dcs_flavors.single_flavors.flavors[0].name
  availability_zones = var.az
  password           = var.dcs_password
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
}