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

resource "huaweicloud_cce_cluster" "cce-demo" {
  name                   = "cce-${var.demo_name}"
  flavor_id              = var.cce_cluster_flavor
  vpc_id              = var.vpc_id
  subnet_id           = var.subnet_id
  container_network_type = "overlay_l2"
}

resource "huaweicloud_cce_node" "node1" {
  cluster_id        = huaweicloud_cce_cluster.cce-demo.id
  name              = "node-1-${var.demo_name}"
  flavor_id         = "s6.large.4"
  availability_zone = var.az
  password   = "Altron194"

  root_volume {
    size       = 40
    volumetype = "SATA"
  }
  data_volumes {
    size       = 100
    volumetype = "SATA"
  }
}

resource "huaweicloud_cce_node" "node2" {
  cluster_id        = huaweicloud_cce_cluster.cce-demo.id
  name              = "node-2-${var.demo_name}"
  flavor_id         = "s6.large.4"
  availability_zone = var.az
  password   = "Altron194"

  root_volume {
    size       = 40
    volumetype = "SATA"
  }
  data_volumes {
    size       = 100
    volumetype = "SATA"
  }
}