module "networking" {
  source      = "../modules/networking"
  environment = terraform.workspace
  project     = var.project
  nat_enabled = false
}

module "ecoflow" {
  source      = "../modules/ecoflow"
  environment = terraform.workspace
  project     = var.project
  vpc_id      = module.networking.vpc_properties.id
  subnet_id   = module.networking.public_subnets_properties[0].id
}
