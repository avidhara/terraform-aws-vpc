#### VPC ####

resource "aws_vpc" "this" {
  count                                = var.create_vpc ? 1 : 0
  cidr_block                           = var.cidr_block
  instance_tenancy                     = var.instance_tenancy
  ipv4_ipam_pool_id                    = var.ipv4_ipam_pool_id
  ipv4_netmask_length                  = var.ipv4_netmask_length
  ipv6_cidr_block                      = var.ipv6_cidr_block
  ipv6_ipam_pool_id                    = var.ipv6_ipam_pool_id
  ipv6_netmask_length                  = var.ipv6_netmask_length
  ipv6_cidr_block_network_border_group = var.ipv6_cidr_block_network_border_group
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_dns_support                   = var.enable_dns_support
  enable_classiclink                   = var.enable_classiclink
  enable_classiclink_dns_support       = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block     = var.assign_generated_ipv6_cidr_block
  tags = merge(
    {
      "Name"        = format("%s-vpc-%s", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
  lifecycle {
    create_before_destroy = true
  }
}

#### DHCP Options ####

resource "aws_vpc_dhcp_options" "this" {
  domain_name          = var.domain_name
  domain_name_servers  = var.domain_name_servers
  ntp_servers          = var.ntp_servers
  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type
  tags = merge(
    {
      "Name"        = format("%s-vpc-%s", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
  lifecycle {
    create_before_destroy = true
  }
}

#### DHCP Association ####

resource "aws_vpc_dhcp_options_association" "this" {
  vpc_id          = aws_vpc.this[0].id
  dhcp_options_id = aws_vpc_dhcp_options.this.id
}

### Ensure the default security group of every VPC restricts all traffic  and NACL

resource "aws_default_security_group" "thi" {
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    {
      "Name"        = format("%s-%s-default-sg", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
}


resource "aws_default_network_acl" "this" {
  default_network_acl_id = aws_vpc.this[0].default_network_acl_id

  tags = merge(
    {
      "Name"        = format("%s-%s-default-sg", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
}

#### VPC Flow Logs ####

resource "aws_flow_log" "this" {
  count                    = var.enable_flow_logs ? 1 : 0
  traffic_type             = var.traffic_type
  eni_id                   = var.eni_id
  iam_role_arn             = var.iam_role_arn == "" ? aws_iam_role.this[0].arn : var.iam_role_arn
  log_destination_type     = var.log_destination_type
  log_destination          = var.log_destination == "" ? aws_cloudwatch_log_group.this[0].arn : var.log_destination
  vpc_id                   = aws_vpc.this[0].id
  subnet_id                = var.subnet_id
  log_format               = var.log_format
  max_aggregation_interval = var.max_aggregation_interval
  dynamic "destination_options" {
    for_each = var.destination_options
    content {
      file_format                = lookup(destination_options.value, "file_format", null)
      hive_compatible_partitions = lookup(destination_options.value, "hive_compatible_partitions", null)
      per_hour_partition         = lookup(destination_options.value, "per_hour_partition", null)
    }
  }

  tags = merge(
    {
      "Name"        = format("%s-vpc-%s", var.name, var.environment)
      "Environment" = format("%s", var.environment)
    },
    var.additional_tags
  )
  lifecycle {
    create_before_destroy = true
  }
}
