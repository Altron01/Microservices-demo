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

data "huaweicloud_dms_product" "test" {
  engine            = "kafka"
  instance_type     = "cluster"
  version           = "2.3.0"
  bandwidth         = "100MB"
  storage_spec_code = "dms.physical.storage.ultra"
}

resource "huaweicloud_dms_kafka_instance" "dms-demo" {
  name               = "dms-${var.demo_name}"
  product_id         = data.huaweicloud_dms_product.test.id
  engine_version     = data.huaweicloud_dms_product.test.version
  storage_spec_code  = data.huaweicloud_dms_product.test.storage_spec_code
  vpc_id             = var.vpc_id
  network_id         = var.subnet_id
  security_group_id  = var.security_group_id
  availability_zones   = var.az

  manager_user     = "kafka-user"
  manager_password = "Kafkatest@123"
}

resource "huaweicloud_dms_kafka_topic" "topic-demo" {
  instance_id = huaweicloud_dms_kafka_instance.dms-demo.id
  name        = "topic-user"
  partitions  = 1
}