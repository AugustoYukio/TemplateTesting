locals {
  name     = "prod-${{values.project_name | lower | replace(" ", "_") }}"
  other_name    = "prod-{{values.project_name | lower | replace(" ", "_") }}"
  other_name_to    = prod-{{values.project_name | lower | replace(" ", "_") }}
  other_name_to_one    = prod-${{values.project_name | lower | replace(" ", "_") }}
  vpc_name = "${local.name}-vpc"
  cluster_name = "${local.name}-cluster-eks"
}

variable "region" {
  default     = ${{values.region}}
  description = "AWS region"
}
