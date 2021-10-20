data "aws_availability_zones" "available" {}

data "aws_caller_identity" "current" {}
resource "random_string" "suffix" {
  length  = 8
  special = false
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.10.0"

  name = "${local.vpc_name}"
  cidr = "{{values.cidr_prod}}"
  azs  = data.aws_availability_zones.available.names
  // each subnet supports 2k hosts
  private_subnets      = [${{values.private_subnets_prod}}]
  public_subnets       = [${{values.public_subnets_prod}}]
  enable_nat_gateway   = {{values.enable_nat_gateway_prod}}
  single_nat_gateway   = {{values.single_nat_gateway_prod}}
  enable_dns_hostnames = ${{values.enable_dns_hostnames_prod}}

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                  = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
  }
}
