###################################### Global Variables ###########################################

variable "application" {
  type        = string
  description = "The name of the app being deployed. This is used for naming/tagging or resources"
}

variable "application_endpoint" {
  type        = string
  description = "The domain name used to access the application"
}

variable "env" {
  type        = string
  description = "The name of the environment being deployed"
}

variable "region" {
  type        = string
  description = "The aws region being deployed into"
}
###################################### EKS Variables ###########################################

variable "eks_cluster_name" {
  type        = string
  description = "The name to give to the eks cluster. This will be prepended with the environment"
}

variable "eks_cluster_users" {
  type        = list(map(string))
  description = "A list of maps holding info for users to be added to the cluster"
}

variable "eks_master_inbound_cidrs" {
  type        = list(string)
  description = "A list of cidr blocks to allow inbound to the master nodes"
}

variable "eks_node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pool configurations"
}

variable "eks_node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"
}
###################################### VPC Variables ###########################################

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "vpc_name" {
  type        = string
  description = "The name to give the vpc"
}

variable "vpc_subnet_availability_zones_public" {
  type        = list(string)
  description = "A list of availability zones to put the public subnets in"
}

variable "vpc_subnet_availability_zones_private" {
  type        = list(string)
  description = "A list of availability zones to put the private subnets in"
}

variable "vpc_subnet_cidr_blocks_private" {
  type        = list(string)
  description = "A list of cidr blocks for the public subnets"
}

variable "vpc_subnet_cidr_blocks_public" {
  type        = list(string)
  description = "A list of cidr blocks for the public subnets"
}
