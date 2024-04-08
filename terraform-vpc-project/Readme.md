Project for creating the vpc and add a security group with ec2 instance

resource:
1. aws_vpc.this
2. aws_subnet.this
3. aws_internet_gateway.this
4. aws_route_table.this
5. aws_route_table_association.this
6. aws_security_group.this
7. aws_instance.this

variable:
1. variable "vpc_parameter" {
  description = "vpc parameters"
  type = map(object({
    cidr_block           = string
    enable_dns_support   = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    tags                 = optional(map(string), {})
  }))
  default = {}
}


2. variable "subnet_parameter" {
  description = "subnetparmeter"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    vpc_name          = string
    tags              = optional(map(string), {})
  }))
}

3. variable "internetGateWay_parameter" {
  description = "igw parameter"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

4. variable "routeTable_parameter" {
  description = "route table parameter"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
    route = optional(list(object({
      cidr_block = string
      gateway_id = string
    })), [])
  }))
  default = {}
}

5. variable "routeTableAssociation_parameter" {
  description = "routeTableAssociation_parameter"
  type = map(object({
    subnet_name     = string
    routeTable_name = string
  }))

  default = {}
}

6. variable "securityGroup_parameter" {
  description = "securityGroup_parameter"
  type = map(object({
    vpc_id = optional(string, null)
    ingress = list(object({
      cidr_blocks = optional(list(string), [])
      from_port   = optional(number, 0)
      to_port     = optional(number, 0)
      protocol    = optional(string, "-1")
    }))
    egress = list(object({
      cidr_blocks = optional(list(string), [])
      from_port   = optional(number, 0)
      to_port     = optional(number, 0)
      protocol    = optional(string, "-1")
    }))
    tags = optional(map(string), {})
  }))
  default = {}
}

7. variable "ec2_parameter" {
    description = "ec2 parameter"
    type = map(object({
      ami = string
      instance_type= string
      subnet_id=string
      vpc_security_group_ids=list(string)
      key_name=string
      associate_public_ip_address=optional(bool,true)
      tags=map(string)
    }))
    default = {}
}

