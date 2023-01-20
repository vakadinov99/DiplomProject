resource "aws_vpc" "vpc" {
  cidr_block                        = var.cidr_block
  instance_tenancy                  = var.instance_tenancy
  enable_dns_support                = var.enable_dns_support
  enable_dns_hostnames              = var.enable_dns_hostnames
  enable_classiclink                = var.enable_classiclink
  enable_classiclink_dns_support    = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block  = var.assign_generated_ipv6_cidr_block
  tags                              = merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-vpc"}))
}

resource "aws_internet_gateway" "vpc" {
  vpc_id  = aws_vpc.vpc.id
  tags    = merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-internet-gateway-${aws_vpc.vpc.id}"}))
}

resource "aws_subnet" "public" {
  count             = length(var.subnet_cidr_blocks_public)
  availability_zone = var.subnet_availability_zones_public[count.index]
  cidr_block        = var.subnet_cidr_blocks_public[count.index]
  vpc_id            = aws_vpc.vpc.id
  tags              = merge(tomap({"kubernetes.io/role/elb"="1"}),merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-subnet-public-${aws_vpc.vpc.id}"})))
}

resource "aws_subnet" "private" {
  count             = length(var.subnet_cidr_blocks_private)
  availability_zone = var.subnet_availability_zones_private[count.index]
  cidr_block        = var.subnet_cidr_blocks_private[count.index]
  vpc_id            = aws_vpc.vpc.id
  tags              = merge(tomap({"kubernetes.io/role/internal-elb"="1"}),merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-subnet-private-${aws_vpc.vpc.id}"})))
}

resource "aws_route_table" "public" {
  count   = length(var.subnet_cidr_blocks_public) > 0 ? 1 : 0
  vpc_id  = aws_vpc.vpc.id
  tags    = merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-route-table-public-${aws_vpc.vpc.id}"}))
}

resource "aws_route_table" "private" {
  count   = length(var.subnet_cidr_blocks_private) > 0 ? 1 : 0
  vpc_id  = aws_vpc.vpc.id
  tags    = merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-route-table-private-${aws_vpc.vpc.id}"}))
}

resource "aws_route_table_association" "public" {
  count           = length(var.subnet_cidr_blocks_public)
  route_table_id  = aws_route_table.public.*.id[0]
  subnet_id       = aws_subnet.public.*.id[count.index]

}

resource "aws_route_table_association" "private" {
  count          = length(var.subnet_cidr_blocks_private)
  route_table_id = aws_route_table.private.*.id[0]
  subnet_id      = aws_subnet.private.*.id[count.index]
}

resource "aws_eip" "ng" {
  count = length(var.subnet_cidr_blocks_private) > 0 ? length(var.subnet_cidr_blocks_public) : 0
  vpc   = "true"
  tags  = merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-eip-natgateway-${aws_vpc.vpc.id}"}))
}

resource "aws_nat_gateway" "ng" {
  count         = length(var.subnet_cidr_blocks_private) > 0 ? length(var.subnet_cidr_blocks_public) : 0
  allocation_id = aws_eip.ng.*.id[count.index]
  subnet_id     = aws_subnet.public.*.id[count.index]
  tags          = merge(var.tags,tomap({"Name"="${var.environment}-${var.name}-natgateway-${aws_vpc.vpc.id}"}))
}

resource "aws_route" "internet" {
  route_table_id          = aws_route_table.public.*.id[0]
  gateway_id              = aws_internet_gateway.vpc.id
  destination_cidr_block  = "0.0.0.0/0"
}

resource "aws_route" "nat" {
  count                   = length(var.subnet_cidr_blocks_private) > 0 ? 1 : 0
  route_table_id          = aws_route_table.private.*.id[0]
  nat_gateway_id          = aws_nat_gateway.ng.*.id[0]
  destination_cidr_block  = "0.0.0.0/0"
}



