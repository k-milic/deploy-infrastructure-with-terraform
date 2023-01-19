# Defines the providers that will be used in this configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50.0"
    }
  }
}

# Sets the region for the provider
provider "aws" {
  region = "us-east-1"
}

