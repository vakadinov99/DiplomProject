# Network Terraform Module

Module that creates VPC network

## Usage

Basic usage of this module is as follows:

```
module "network" {
  source                            = "../modules/network"
  cidr_block                        = var.vpc_cidr_block
  enable_dns_hostnames              = "true"
  subnet_cidr_blocks_public         = var.vpc_subnet_cidr_blocks_public
  subnet_cidr_blocks_private        = var.vpc_subnet_cidr_blocks_private
  subnet_availability_zones_public  = var.vpc_subnet_availability_zones_public
  subnet_availability_zones_private = var.vpc_subnet_availability_zones_private
  name                              = var.vpc_name
  environment                       = var.env

  tags = {
    application                                                = var.application
    environment                                                = var.env
    component                                                  = "network"
    "kubernetes.io/cluster/${var.env}-${var.eks_cluster_name}" = "shared"
  }
}
```
## Resources created
| Resource | Description               |
|----------|---------------------------|
|aws_eip.ng| Elastic IP for NAT gateway |
|aws_internet_gateway.vpc| Internet gateway          |
|aws_nat_gateway.ng| NAT gateway               
|aws_route.internet| Internet route|
|aws_route.nat| NAT route|
|aws_route_table.private| Private routing table|
|aws_route_table.public| Public routing table|
|aws_route_table_association.private| Private route table association|
|aws_route_table_association.public| Public route table association|
|aws_subnet.private| Private subnet|
|aws_subnet.public| Public subnet|
|aws_vpc.vpc| VPC network|


## Variables

| Variable | Description |
| --- | --- |
|cidr_block|The CIDR block for the VPC.|
|name|The name to give the vpc|
|environment|The environment being deployed into|
|instance_tenancy|A tenancy option for instances launched into the VPC|
|enable_dns_support|A boolean flag to enable/disable DNS support in the VPC. Defaults true|
|enable_dns_hostnames|A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false|
|enable_classiclink|A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. Defaults false|
|enable_classiclink_dns_support|A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic.|
|assign_generated_ipv6_cidr_block|Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false|
|subnet_cidr_blocks_public|A list of cidr blocks for the public subnets|
|subnet_cidr_blocks_private|A list of cidr blocks for the public subnets|
|subnet_availability_zones_public|A list of availability zones to put the public subnets in|
|subnet_availability_zones_private|A list of availability zones to put the private subnets in|
|tags|A mapping of tags to assign to the resource.|

