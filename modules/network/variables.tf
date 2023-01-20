variable "cidr_block" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "name" {
  type        = string
  description = "The name to give the vpc"
}

variable "environment" {
  type        = string
  description = "The environment being deployed into"
}

variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "enable_dns_support" {
  type        = string
  description = "A boolean flag to enable/disable DNS support in the VPC. Defaults true"
  default     = "true"
}

variable "enable_dns_hostnames" {
  type        = string
  description = "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false"
  default     = "false"
}

variable "enable_classiclink" {
  type        = string
  description = "A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. Defaults false"
  default     = "false"
}

variable "enable_classiclink_dns_support" {
  type        = string
  description = "A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  default     = "false"
}

variable "assign_generated_ipv6_cidr_block" {
  type        = string
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false"
  default     = "false"
}

variable subnet_cidr_blocks_public {
  type        = list(string)
  description = "A list of cidr blocks for the public subnets"
}

variable subnet_cidr_blocks_private {
  type        = list(string)
  description = "A list of cidr blocks for the public subnets"
}

variable "subnet_availability_zones_public" {
  type        = list(string)
  description = "A list of availability zones to put the public subnets in"
}

variable "subnet_availability_zones_private" {
  type        = list(string)
  description = "A list of availability zones to put the private subnets in"
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}