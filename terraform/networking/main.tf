terraform {
  required_providers {
    huaweicloud = {
      source = "huaweicloud/huaweicloud"
    }
  }
}

variable "demo_name" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "subnet_gateway" {}
variable "primary_dns" {}

resource "huaweicloud_vpc" "vpc-demo" {
  name = "vpc_${var.demo_name}"
  cidr = var.vpc_cidr
}

resource "huaweicloud_vpc_subnet" "subnet-demo" {
  vpc_id      = huaweicloud_vpc.vpc-demo.id
  name        = "subnet_${var.demo_name}"
  cidr        = var.subnet_cidr
  gateway_ip  = var.subnet_gateway
  primary_dns = var.primary_dns
}

resource "huaweicloud_networking_secgroup" "secgroup-demo" {
  name        = "secgroup-demo"
  description = "demo security group"
}

# allow ping
resource "huaweicloud_networking_secgroup_rule" "allow-all" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.secgroup-demo.id
}

resource "huaweicloud_nat_gateway" "nat-demo" {
  name        = "nat-demo"
  description = "test for terraform"
  spec        = "1"
  vpc_id      = huaweicloud_vpc.vpc-demo.id
  subnet_id   = huaweicloud_vpc_subnet.subnet-demo.id
}

resource "huaweicloud_vpc_eip" "eip-demo" {
  publicip {
    type = "5_bgp"
  }

  bandwidth {
    share_type  = "PER"
    name        = "eip-demo"
    size        = 10
    charge_mode = "traffic"
  }
}

resource "huaweicloud_nat_snat_rule" "snat-demo" {
  nat_gateway_id = huaweicloud_nat_gateway.nat-demo.id
  floating_ip_id = huaweicloud_vpc_eip.eip-demo.id
  subnet_id      = huaweicloud_vpc_subnet.subnet-demo.id
}

output "vpc_id" {
  value = huaweicloud_vpc.vpc-demo.id
}

output "subnet_id" {
  value = huaweicloud_vpc_subnet.subnet-demo.id
}

output "security_group_id" {
  value = huaweicloud_networking_secgroup.secgroup-demo.id
}