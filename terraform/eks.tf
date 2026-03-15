resource "aws_eks_cluster" "eks_new" {
  name     = "eks_new"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.30"

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

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


resource "aws_eks_access_entry" "jumpbox_access" {
  cluster_name  = aws_eks_cluster.eks_new.name
  principal_arn = aws_iam_role.jumpbox_role.arn
  type          = "STANDARD"
}


resource "aws_eks_access_policy_association" "jumpbox_admin" {
  cluster_name  = aws_eks_cluster.eks_new.name
  principal_arn = aws_iam_role.jumpbox_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}