output "cluster_name" {
  value = aws_eks_cluster.eks_new.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks_new.endpoint
}

output "vpc_id" {
  value = aws_vpc.dev_vpc.id
}

output "private_subnets" {
  value = [
    aws_subnet.private_subnet1.id,
    aws_subnet.private_subnet2.id
  ]
}