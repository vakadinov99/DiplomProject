# EFS Terraform Module

Module that creates EFS filesystem

## Usage

Basic usage of this module is as follows:

```
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
```
## Resources created
| Resource | Description                                                                                 |
|----------|---------------------------------------------------------------------------------------------|
|aws_eks_cluster.eks| EKS cluster                                                                                 |
|aws_eks_node_group.node_pools| node pool for the EKS cluster                                                               |
|aws_iam_instance_profile.eks | Instance profile for the nodes                                                              |
|aws_iam_role.eks-master | IAM role for the master node                                                                |
|aws_iam_role.eks-worker | IAM role for the worker nodes. Any extra IAM permissions for the pods are to be added there |
|aws_iam_role_policy_attachment.eks-ec2-container-read-only| IAM role policy attachment                                                                  |
|aws_iam_role_policy_attachment.eks-master-cluster-policy| IAM role policy attachment                                                                  |
|aws_iam_role_policy_attachment.eks-master-service-policy| IAM role policy attachment                                                                  |
|aws_iam_role_policy_attachment.eks-worker-asg-policy| Policy for the worker node group                                                            |
|aws_iam_role_policy_attachment.eks-worker-cni-policy| Policy for the worker node group                                                            |
|aws_iam_role_policy_attachment.eks-worker-policy| Policy for the worker node group                                                            
|aws_iam_role_policy_attachment.eks-worker-s3-read-policy| Policy for the worker node group                                                            |
|aws_iam_role_policy_attachment.eks-worker-diplomproject-eks-lb-policy| Policy for the worker node group                                                            |
|aws_security_group.eks-master| Security group for the master nodes                                                         |
|aws_security_group_rule.eks-master-ingress-workstation-https| Security group for the master nodes                                                         |
|local_file.configmap| Helper resource to add users to the EKS cluster                                             |
|null_resource.setup_cluster_auth|Helper resource to add users to the EKS cluster|


## Variables

| Variable | Description |
| --- | --- |
|environment|The environment being deployed into|
|region|The region being deployed into|
|cluster_name|The name to give to the eks cluster. This will be prepended with the environment|
|cluster_tags|A mapping of tags to assign to the cluster resources.|
|cluster_users|A list of user to add to the cluster|
|subnet_ids_public|List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane.|
|subnet_ids_private|List of subnet IDs. Must be in at least two different availability zones. Amazon EKS creates cross-account elastic network interfaces in these subnets to allow communication between your worker nodes and the Kubernetes control plane.|
|vpc_id|The id of the vpc to deploy the eks cluster into|
|master_inbound_cidrs|A list of cidr blocks to allow inbound to the master nodes|
|node_pools|List of maps containing node pool configurations|
|node_pools_labels|Map of maps containing node labels by node-pool name|

## Outputs

| Name | Description                                          |
| --- |------------------------------------------------------|
| eks_cluster_kubeconfig| AWS cli command to get kubectl access to the cluster |