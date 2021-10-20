terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "${{values.bucket_name_prod}}"
    key    = "${{values.key_path_prod}}"
    region = "${{values.region}}"
    shared_credentials_file = "~/.aws/credentials"
    profile = "default"
  }
}

# Configure the AWS Provider
provider "aws" {
  version = "~> 3.0"
  region  = "${{values.region}}"
  shared_credentials_file = "~/.aws/credentials"
  profile = "default"
}
