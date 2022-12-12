# Configure the HUAWEI CLOUD provider.
provider "huaweicloud" {
  region     = "la-south-2"
  access_key = "MWR6KSPAA9RZWA7ZOD4V"
  secret_key = "YrI1h9EFoYaRoLUBaATrEWisMfJy6yag3in3V15V"
}

module "networking" {
  source = "./networking"
}
