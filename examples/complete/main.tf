

module "vpc_resource"{
    source = "../../"
    cidr_block = var.cidr_block
    instance_tenancy = var.instance_tenancy # Default is default
    additional_tags = var.additional_tags # Must be map(string)
}