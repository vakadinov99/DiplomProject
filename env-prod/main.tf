module "network" {
  source                            = "../modules/network"
  cidr_block                        = var.vpc_cidr_block
  enable_dns_hostnames              = "true"
  subnet_cidr_blocks_public         = var.vpc_subnet_cidr_blocks_public
  subnet_cidr_blocks_private        = var.vpc_subnet_cidr_blocks_private
  subnet_availability_zones_public  = var.vpc_subnet_availability_zones_public
  subnet_availability_zones_private = var.vpc_subnet_availability_zones_private
  name                              = var.vpc_name
  environment                       = var.env

  tags = {
    application                                                = var.application
    environment                                                = var.env
    component                                                  = "network"
    "kubernetes.io/cluster/${var.env}-${var.eks_cluster_name}" = "shared"
  }
}

module "eks_cluster" {
  source               = "../modules/eks"
  depends_on           = [module.network]
  environment          = var.env
  region               = var.region
  cluster_name         = var.eks_cluster_name
  cluster_users        = var.eks_cluster_users
  master_inbound_cidrs = var.eks_master_inbound_cidrs
  subnet_ids_private   = module.network.subnet_ids_private
  subnet_ids_public    = module.network.subnet_ids_public
  vpc_id               = module.network.vpc_id
  node_pools           = var.eks_node_pools
  node_pools_labels    = var.eks_node_pools_labels

  cluster_tags = {
    application = var.application
    environment = var.env
    component   = "kubernetes"
  }
}