resource "aws_eks_node_group" "nodes" {

  cluster_name    = module.eks.cluster_name
  node_group_name = "worker-nodes"
  node_role_arn   = module.eks.node_iam_role_arn
  subnet_ids      = module.vpc.private_subnets

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }

  instance_types = ["t3.medium"]
}