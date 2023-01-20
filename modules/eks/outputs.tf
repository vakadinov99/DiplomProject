output "cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "cluster_region" {
  value = var.region
}

output "security_group_id" {
  value = aws_security_group.eks-master.id
}

output "cluster_security_group_id" {
  value = join("", aws_eks_cluster.eks.*.vpc_config.0.cluster_security_group_id)
}
