variable "create_vpc" {
  type        = bool
  description = "Controls if VPC should be created (it affects almost all resources)"
  default     = true
}


variable "name" {
  type        = string
  description = "Name to be used on all the resources as identifier"
  default     = "Example"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "192.168.0.0/16"
}

variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "ipv4_ipam_pool_id" {
  type        = string
  description = "(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR. IPAM is a VPC feature that you can use to automate your IP address management workflows including assigning, tracking, troubleshooting, and auditing IP addresses across AWS Regions and accounts. Using IPAM you can monitor IP address usage throughout your AWS Organization."
  default     = null
}

variable "ipv4_netmask_length" {
  type        = string
  description = "(Optional) The netmask length of the IPv4 CIDR you want to allocate to this VPC. Requires specifying a ipv4_ipam_pool_id."
  default     = null
}

variable "ipv6_cidr_block" {
  type        = string
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using ipv6_netmask_length."
  default     = null
}

variable "ipv6_ipam_pool_id" {
  type        = string
  description = "(Optional) IPAM Pool ID for a IPv6 pool. Conflicts with assign_generated_ipv6_cidr_block."
  default     = null
}

variable "ipv6_netmask_length" {
  type        = number
  description = "(Optional) Netmask length to request from IPAM Pool. Conflicts with ipv6_cidr_block. This can be omitted if IPAM pool as a allocation_default_netmask_length set. Valid values: 56."
  default     = null
}

variable "ipv6_cidr_block_network_border_group" {
  type        = string
  description = "(Optional) By default when an IPv6 CIDR is assigned to a VPC a default ipv6_cidr_block_network_border_group will be set to the region of the VPC. This can be changed to restrict advertisement of public addresses to specific Network Border Groups such as LocalZones."
  default     = null
}

variable "enable_classiclink" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false."
  default     = false
}

variable "enable_classiclink_dns_support" {
  type        = string
  description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  default     = null
}

variable "enable_dns_support" {
  type        = bool
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}
variable "enable_dns_hostnames" {
  type        = bool
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = false
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC"
  default     = false
}

variable "environment" {
  type        = string
  description = "Environment in tags to identidy"
  default     = "Dev"
}
variable "additional_tags" {
  type        = map(string)
  description = "Additional Tags to aws resources"
  default     = {}
}


################For DHCP Options ##############

variable "domain_name" {
  type        = string
  description = "suffix domain name to use by default when resolving non Fully Qualified Domain Names"
  default     = "ec2.internal"
}

variable "domain_name_servers" {
  type        = list(string)
  description = "ist of name servers to configure in /etc/resolv.conf"
  default     = ["AmazonProvidedDNS"]
}

variable "ntp_servers" {
  type        = list(string)
  description = "(Optional) List of NTP servers to configure."
  default     = null
}

variable "netbios_name_servers" {
  type        = list(string)
  description = "(Optional) List of NETBIOS name servers."
  default     = null
}

variable "netbios_node_type" {
  type        = number
  description = "Optional) The NetBIOS node type (1, 2, 4, or 8). AWS recommends to specify 2 since broadcast and multicast are not supported in their network. For more information about these node types"
  default     = 2
}

############## VPC Flow logs #############
variable "enable_flow_logs" {
  type        = bool
  description = "Do you want to enable vpc flow logs"
  default     = true
}

variable "traffic_type" {
  type        = string
  description = "The type of traffic to capture. Valid values: ACCEPT,REJECT, ALL"
  default     = "ALL"
}

variable "eni_id" {
  type        = string
  description = "(Optional) Elastic Network Interface ID to attach to"
  default     = null
}

variable "iam_role_arn" {
  type        = string
  description = "The ARN for the IAM role that's used to post flow logs to a CloudWatch Logs log group"
  default     = ""
}

variable "log_destination_type" {
  type        = string
  description = "The type of the logging destination. Valid values: cloud-watch-logs, s3. Default: cloud-watch-logs."
  default     = "cloud-watch-logs"
}

variable "log_destination" {
  type        = string
  description = "The ARN of the logging destination"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "(Optional) Subnet ID to attach to"
  default     = null
}

variable "log_format" {
  type        = string
  description = "The fields to include in the flow log record, in the order in which they should appear."
  default     = ""
}

variable "max_aggregation_interval" {
  type        = number
  description = "(Optional) The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: 60 seconds (1 minute) or 600 seconds (10 minutes). Default: 600."
  default     = 600
}

variable "destination_options" {
  type        = any
  description = "(Optional) Describes the destination options for a flow log. More details below."
  default = [

  ]
}

### Cloudwatch logs 
variable "log_retention_in_days" {
  type        = number
  description = "Specifies the number of days you want to retain log events in the specified log group"
  default     = 90
}

variable "kms_key_id" {
  type        = string
  description = "(Optional) The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group."
  default     = null
}


### Internet Gateway

variable "create_igw" {
  type        = bool
  description = "Do you want to Create Internet Gateway"
  default     = true
}