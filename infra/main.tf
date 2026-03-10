module "vpc" {
    source = "./modules/vpc"
    project_name = var.project_name
    vpc_cidr = var.vpc_cidr
}

module "ecr" {
    source = "./modules/ecr"
    project_name = var.project_name
}


module "acm" {
    source = "./modules/acm"
    project_name = var.project_name
    domain_name = var.domain_name
    subject_alternative_names = var.subject_alternative_names
}

module "alb" {
    source = "./modules/alb"
    project_name = var.project_name
    vpc_id = module.vpc.vpc_id
    subnet_ids = module.vpc.public_subnet_ids
    certificate_arn = module.acm.certificate_arn
    container_port = var.container_port
}

module "ecs" {
    source = "./modules/ecs"
    project_name = var.project_name
    vpc_id = module.vpc.vpc_id
    public_subnet_ids = module.vpc.public_subnet_ids
    repo_url = module.ecr.repo_url
    target_group_arn = module.alb.target_group_arn
    alb_sg_id = module.alb.alb_sg_id
    container_port = var.container_port
}