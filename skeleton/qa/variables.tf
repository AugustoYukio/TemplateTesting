locals {
  name     = "qa-${{values.project_name | lower | replace(" ", "_") }}"
  vpc_name = "${local.name}-vpc"
  cluster_name = "${local.name}-cluster-eks"
}

variable "region" {
  default     = "${{values.region}}"
  description = "AWS region"
}