provider "aws" {
  region = "us-east-1"
}


module "vpc_resource" {
  source = "../../"
  name   = "example"
  cidr_block   = "10.0.0.0/16"
  environment = "development"
  instance_tenancy = "default"
  create_igw = true
  additional_tags  = {
    Owner       = "devops"
    CostAllocationID = "1234"
  }
}