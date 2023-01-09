# Configure the HUAWEI CLOUD provider.
provider "huaweicloud" {
  region     = "la-south-2"
  access_key = "MWR6KSPAA9RZWA7ZOD4V"
  secret_key = "YrI1h9EFoYaRoLUBaATrEWisMfJy6yag3in3V15V"
}

data "huaweicloud_availability_zones" "myaz" {
  region              = "la-south-2"
}

module "networking" {
  source          = "./networking"
  demo_name       = var.demo_name
  vpc_cidr        = var.vpc_cidr
  subnet_cidr     = var.subnet_cidr
  subnet_gateway  = var.subnet_gateway
  primary_dns     = var.primary_dns
}


module "database" {
  source = "./db"
  depends_on = [
    module.networking
  ]
  demo_name       = var.demo_name
  az = [data.huaweicloud_availability_zones.myaz.names[0]]
  vpc_id = module.networking.vpc_id
  subnet_id = module.networking.subnet_id
  security_group_id = module.networking.security_group_id
}

module "computing" {
  source = "./computing"
  depends_on = [
    module.networking
  ]
  demo_name       = var.demo_name
  az = data.huaweicloud_availability_zones.myaz.names[0]
  vpc_id = module.networking.vpc_id
  subnet_id = module.networking.subnet_id
}

module "middleware" {
  source = "./middleware"
  depends_on = [
    module.networking
  ]
  demo_name       = var.demo_name
  az = [data.huaweicloud_availability_zones.myaz.names[0]]
  vpc_id = module.networking.vpc_id
  subnet_id = module.networking.subnet_id
  security_group_id = module.networking.security_group_id
}
