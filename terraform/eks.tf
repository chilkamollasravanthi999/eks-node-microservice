module "eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_name    = "dev-eks"
  cluster_version = "1.29"

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id
}