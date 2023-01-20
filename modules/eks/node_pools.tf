resource "aws_eks_node_group" "node_pools" {
  for_each        = local.node_pools
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = lookup(each.value, "name", null)
  node_role_arn   = aws_iam_role.eks-worker.arn
  subnet_ids      = var.subnet_ids_private
  disk_size       = lookup(each.value, "disk_size_gb", 100)
  instance_types  = [ lookup(each.value, "instance_type", "t3.medium") ]
  tags            = var.cluster_tags

  labels          = merge(
    local.node_pools_labels["all"],
    { "node-pool": lookup(each.value, "name", null) },
    jsondecode(lookup(each.value, "additional_labels", "{}"))
  )

  scaling_config {
    desired_size = lookup(each.value, "desired_node_count", 3)
    max_size     = lookup(each.value, "max_node_count", 3)
    min_size     = lookup(each.value, "min_node_count", 6)
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-worker-policy,
    aws_iam_role_policy_attachment.eks-worker-cni-policy,
    aws_iam_role_policy_attachment.eks-ec2-container-read-only,
  ]
}