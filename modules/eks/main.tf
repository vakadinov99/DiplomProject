resource "aws_eks_cluster" "eks" {
  name     = "${var.environment}-${var.cluster_name}"
  role_arn = aws_iam_role.eks-master.arn
  tags     = var.cluster_tags

  vpc_config {
    subnet_ids         = var.subnet_ids_public
    security_group_ids = [aws_security_group.eks-master.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-master-service-policy,
    aws_iam_role_policy_attachment.eks-master-cluster-policy,
  ]
}

resource "local_file" "configmap" {
  depends_on = [aws_eks_cluster.eks]
  content    = local.configmap_content
  filename   = local.configmap_filename
}

resource "null_resource" "setup_cluster_auth" {
  depends_on = [local_file.configmap]
  triggers = {
    configmap = local_file.configmap.content
  }
  provisioner "local-exec" {
    command = <<EOF
aws eks --region ${var.region} update-kubeconfig --name ${aws_eks_cluster.eks.name}
kubectl apply -f ${local_file.configmap.filename}
EOF
  }
}
