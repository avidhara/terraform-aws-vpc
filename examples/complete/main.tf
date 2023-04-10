

module "vpc_resource" {
  source           = "../../"
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy # Default is default
  tags             = var.tags             # Must be map(string)
}
