###################################### Global Variables ###########################################
application          = "diplom-project"
# Conflicting CNAME exists for k8s-prod therefore temporarily updated to production to prevent testing delays
# application_endpoint = "k8s-prod.diplomproject.com"
application_endpoint = "k8s-production.diplomproject.com"
env                  = "prod"
region               = "us-east-1"
###################################### EKS Variables ##############################################
eks_cluster_name = "diplomproject-eks"
eks_master_inbound_cidrs = [
  "172.31.0.0/16",  # my ip
]

eks_node_pools = [
  {
    name : "prod",
    disk_size_gb : 100,
    instance_type : "m5.2xlarge",
    desired_node_count : 2,
    min_node_count : 2,
    max_node_count : 9
    additional_labels : "{\"diplom-project\": \"tolerate\"}"
  },
]

eks_node_pools_labels = {
  prod = {
    name      = "prod-node-pool"
    node-pool = "prod"
  }
}

eks_cluster_users = [
  {
    username : "dani"
    arn : "arn:aws:iam::867757353028:user/jvakadinov@tu-sofia.bg"
    groups : "system:masters"
  },
  {
    username : "yordan"
    arn : "arn:aws:iam::867757353028:user/rlt-tf-user"
    groups : "system:masters"
  }
]
###################################### VPC Variables ##############################################
vpc_name                              = "diplomproject"
vpc_cidr_block                        = "10.2.0.0/16"
vpc_subnet_cidr_blocks_public         = ["10.2.0.0/20", "10.2.16.0/20", "10.2.32.0/20"]
vpc_subnet_cidr_blocks_private        = ["10.2.48.0/20", "10.2.64.0/20", "10.2.80.0/20"]
vpc_subnet_availability_zones_public  = ["us-east-1a", "us-east-1b", "us-east-1c"]
vpc_subnet_availability_zones_private = ["us-east-1a", "us-east-1b", "us-east-1c"]