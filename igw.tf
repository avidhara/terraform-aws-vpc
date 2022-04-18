resource "aws_internet_gateway" "this" {
  count  = var.create_igw ? 1 : 0
  vpc_id = aws_vpc.this[0].id

  tags = merge(
    {
      "Name"        = format("%s-%s-igw", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
}
