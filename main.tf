locals {
  tags = {
    created-by = "eks-workshop-v2"
    env        = var.cluster_name
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_role" "cluster_role" {
  name = "LabRole"
}

resource "aws_eks_cluster" "this" {
  name     = "test-eks"
  role_arn = data.aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = module.vpc.private_subnets
  }

}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "test-managed-node-group"
  node_role_arn   = data.aws_iam_role.cluster_role.arn
  subnet_ids      = module.vpc.private_subnets

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 1
  }

  depends_on = [
    aws_eks_cluster.this,
  ]
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.this.name # Your EKS cluster name
  addon_name   = "aws-ebs-csi-driver"      # Add-on name for EBS CSI driver
  # addon_version     = "v1.28.0"                      # Specify the version; adjust as necessary
  resolve_conflicts_on_update = "OVERWRITE" # Overwrite conflicts if they exist
}
