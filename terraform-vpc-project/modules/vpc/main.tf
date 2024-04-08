resource "aws_vpc" "this" {
  for_each             = var.vpc_parameter
  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support   = each.value.enable_dns_support

  tags = merge(each.value.tags, {
    Name : each.key
  })
}


resource "aws_subnet" "this" {
  for_each          = var.subnet_parameter
  vpc_id            = aws_vpc.this[each.value.vpc_name].id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = merge(each.value.tags, {
    Name : each.key
  })
}

resource "aws_internet_gateway" "this" {
  for_each = var.internetGateWay_parameter
  vpc_id   = aws_vpc.this[each.value.vpc_name].id

  tags = merge(each.value.tags, {
    Name : each.key
  })
}

resource "aws_route_table" "this" {
  for_each = var.routeTable_parameter
  vpc_id   = aws_vpc.this[each.value.vpc_name].id

  dynamic "route" {
    for_each = each.value.route
    content {
      cidr_block = route.value.cidr_block
      gateway_id = aws_internet_gateway.this[route.value.gateway_id].id
    }
  }

  tags = merge(each.value.tags, {
    Name : each.key
  })
}

resource "aws_route_table_association" "this" {
  for_each       = var.routeTableAssociation_parameter
  subnet_id      = aws_subnet.this[each.value.subnet_name].id
  route_table_id = aws_route_table.this[each.value.routeTable_name].id
}