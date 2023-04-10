resource "aws_cloudwatch_log_group" "this" {
  count = local.create_log_group

  name              = "/aws/vpc/${var.name}/logs"
  skip_destroy      = var.skip_destroy
  retention_in_days = var.log_retention_in_days
  kms_key_id        = var.kms_key_id

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }

}
