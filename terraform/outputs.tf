output "cluster_name" {
  value = aws_eks_cluster.dev_eks.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.dev_eks.endpoint
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