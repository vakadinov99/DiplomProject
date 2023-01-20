resource "aws_security_group" "eks-master" {
  name        = local.master_sg_name
  description = "Allow all outbound, Inbound from workstation"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.cluster_tags, tomap({"Name"="${var.environment}-${var.cluster_name}-eks-master-sg"}))
}

resource "aws_security_group_rule" "eks-master-ingress-workstation-https" {
  cidr_blocks       = var.master_inbound_cidrs
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-master.id
  to_port           = 443
  type              = "ingress"
}
