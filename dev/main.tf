module "vpc" {
    source                                              = "../child-modules/vpc"
    cidr_block                                          = var.cidr_block
    environment                                         = var.environment
    cidr-subnet-a                                       = var.cidr-subnet-a
    cidr-subnet-b                                       = var.cidr-subnet-b 
    cidr-subnet-c                                       = var.cidr-subnet-c 
    domain                                              = var.domain
}


module "bastion-server" {
    source                                              = "../child-modules/bastion-server"
    ami                                                 = var.ami
    instance_type                                       = var.instance_type
    bastion-subnet                                      = module.vpc.bastion-subnet
    vpc_id                                              = module.vpc.vpc_id   
    scaling                                             = module.auto-scaling.scaling 
}


module "compute-template" {
    source                                             = "../child-modules/compute-template"
    image                                              = var.image
    instance_type_template                             = var.instance_type_template
    vpc_id                                             = module.vpc.vpc_id
    alb-sg                                             = module.load-balancer.alb-sg 
}

module "auto-scaling" {
    source                                             = "../child-modules/auto-scaling"
    desired_capacity                                   = var.desired_capacity
    min_size                                           = var.min_size 
    max_size                                           = var.max_size
    ec2-template                                       = module.compute-template.ec2-template
    private-subnet-a                                   = module.vpc.private-subnet-a
    private-subnet-b                                   = module.vpc.private-subnet-b
    availability-zone-a                                = module.vpc.availability-zone-a 
    availability-zone-b                                = module.vpc.availability-zone-b
    alb-tg                                             = module.load-balancer.alb-tg 
    alb-dns-name                                       = module.load-balancer.alb-dns-name

}

module "load-balancer" {
    source                                             = "../child-modules/load-balancer"
    name                                               = var.name
    elb_type                                           = var.elb_type
    private-subnet-a                                   = module.vpc.private-subnet-a
    private-subnet-b                                   = module.vpc.private-subnet-b
    environment                                        = var.environment
    target_type                                        = var.target_type
    vpc_id                                             = module.vpc.vpc_id
    autoscaling                                        = module.auto-scaling.autoscaling
}


module "route-53"      {
    source                                            = "../child-modules/route-53"
    domain-name                                       = var.domain-name       
    alb-dns-name                                      = module.load-balancer.alb-dns-name 
    alb-zone-id                                       = module.load-balancer.alb-zone-id
}