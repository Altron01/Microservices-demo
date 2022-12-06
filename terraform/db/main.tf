data "huaweicloud_availability_zones" "myaz" {}

resource "huaweicloud_rds_instance" "myinstance" {
  name                = "demo-mysql"
  flavor              = "rds.mysql.n1.large.2"
  ha_replication_mode = "async"
  vpc_id              = data.huaweicloud_vpc.myvpc.id
  subnet_id           = data.huaweicloud_vpc_subnet.mysubnet.id
  security_group_id   = data.huaweicloud_networking_secgroup.mysecgroup.id

  db {
    type     = "MySQL"
    version  = "8.0"
    password = var.rds_password
  }
  volume {
    type = "ULTRAHIGH"
    size = 40
  }
}