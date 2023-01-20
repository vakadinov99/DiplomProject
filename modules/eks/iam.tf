resource "aws_iam_role" "eks-master" {
  name               = local.master_iam_role_name
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "eks-worker" {
  name               = local.worker_iam_role_name
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },

      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-master-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-master.name
}

resource "aws_iam_role_policy_attachment" "eks-master-service-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-master.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-worker.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-worker.name
}

resource "aws_iam_role_policy_attachment" "eks-ec2-container-read-only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-worker.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-asg-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
  role       = aws_iam_role.eks-worker.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-s3-read-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.eks-worker.name
}

resource "aws_iam_role_policy_attachment" "eks-worker-diplomproject-eks-lb-policy" {
  policy_arn = "arn:aws:iam::867757353028:policy/diplomproject-EKS-LB-policy"
  role       = aws_iam_role.eks-worker.name
}

resource "aws_iam_instance_profile" "eks" {
  name = local.worker_iam_instance_profile_name
  role = aws_iam_role.eks-worker.name
}
