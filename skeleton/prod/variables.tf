locals {
  name     = "prod-${{values.project_name}}"
  vpc_name = "${local.name}-vpc"
  cluster_name = "${local.name}-cluster-eks"
}

variable "region" {
  default     = ${{values.region}}
  description = "AWS region"
}
