provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../../modules/network"

  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidr  = "10.0.2.0/24"
  private_subnet_cidr_2 = "10.0.3.0/24"

  aws_region = var.aws_region
}

module "security" {
  source = "../../modules/security"

  vpc_id = module.network.vpc_id
}

module "compute" {
  source = "../../modules/compute"

  subnet_id         = module.network.public_subnet_id
  security_group_id = module.security.ec2_sg_id
  key_name          = var.key_name
  aws_region        = var.aws_region
}

module "database" {
  source = "../../modules/database"

  private_subnet_ids = module.network.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id
}

module "dms" {
  source = "../../modules/dms"

  subnet_ids    = module.network.private_subnet_ids
  dms_sg_id     = module.security.dms_sg_id
  source_db_ip  = module.compute.onprem_private_ip
  rds_endpoint  = module.database.rds_endpoint
}

module "storage" {
  source = "../../modules/storage"
}

module "monitoring" {
  source = "../../modules/monitoring"

  aws_region  = var.aws_region
  bucket_name = module.storage.bucket_name
}