# Defines the providers that will be used in this configuration
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50.0"
    }
    # This provider will be used to generate random numbers in the configuration
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}

# Sets the region for the provider
provider "aws" {
  region = var.aws_region
}

