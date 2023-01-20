locals {
  configmap_filename                = "${path.module}/files/${var.environment}-configmap.yml"
  configmap_content                 = templatefile("${path.module}/files/configmap.tpl", { role_arn = aws_iam_role.eks-worker.arn, users = var.cluster_users })

  master_sg_name                    = "${var.environment}-${var.cluster_name}-eks-master"
  master_iam_role_name              = "${var.environment}-${var.cluster_name}-iam-role-master"
  worker_iam_role_name              = "${var.environment}-${var.cluster_name}-iam-role-worker"
  worker_iam_instance_profile_name  = "${var.environment}-${var.cluster_name}-iam-instance-profile-worker"

  node_pool_names         = [for np in toset(var.node_pools) : np.name]
  node_pools              = zipmap(local.node_pool_names, tolist(toset(var.node_pools)))
  node_pools_labels = merge(
    { all = {} },
    { default-node-pool = {} },
    zipmap(
      [for node_pool in var.node_pools : node_pool["name"]],
      [for node_pool in var.node_pools : {}]
    ),
    var.node_pools_labels
    )
  }