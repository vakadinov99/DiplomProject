output "eks_cluster_kubeconfig" {
  value = "aws eks --region ${module.eks_cluster.cluster_region} update-kubeconfig --name ${module.eks_cluster.cluster_name}"
}