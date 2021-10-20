terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "${{values.bucket_name_qa}}"
    key    = "${{values.key_path_qa}}"
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
