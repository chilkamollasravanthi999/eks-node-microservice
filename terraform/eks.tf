resource "aws_eks_cluster" "dev_eks" {
  name     = "dev-eks"
  role_arn = aws_iam_role.eks_cluster_role.arn

  version = "1.29"

  vpc_config {
    subnet_ids = [
      aws_subnet.private_subnet1.id,
      aws_subnet.private_subnet2.id
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy
  ]
}