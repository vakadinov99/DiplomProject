variable "environment" {
  type        = string
  description = "The environment being deployed into"
}

variable "region" {
  type        = string
  description = "The region being deployed into"
}

variable "cluster_name" {
  type        = string
  description = "The name to give to the eks cluster. This will be prepended with the environment"
}

variable "cluster_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the cluster resources."
}

variable "cluster_users" {
  type        = list(map(string))
  description = "A list of user to add to the cluster"
  default     = []
}

variable "subnet_ids_public" {
  type        = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "subnet_ids_private" {
  type        = list(string)
  description = "List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane."
}

variable "vpc_id" {
  type        = string
  description = "The id of the vpc to deploy the eks cluster into"
}

variable "master_inbound_cidrs" {
  type        = list(string)
  description = "A list of cidr blocks to allow inbound to the master nodes"
}

variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pool configurations"
  default     = [ { name = "default-node-pool" } ]
}

variable "node_pools_labels" {
  type        = map(map(string))
  description = "Map of maps containing node labels by node-pool name"

  default = {
    all               = {}
    default-node-pool = {}
  }
}
