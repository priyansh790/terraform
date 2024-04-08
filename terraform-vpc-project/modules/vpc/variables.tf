variable "vpc_parameter" {
  description = "vpc parameters"
  type = map(object({
    cidr_block           = string
    enable_dns_support   = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    tags                 = optional(map(string), {})
  }))
  default = {}
}


variable "subnet_parameter" {
  description = "subnetparmeter"
  type = map(object({
    cidr_block        = string
    availability_zone = string
    vpc_name          = string
    tags              = optional(map(string), {})
  }))
}

variable "internetGateWay_parameter" {
  description = "igw parameter"
  type = map(object({
    vpc_name = string
    tags     = optional(map(string), {})
  }))
  default = {}
}

variable "routeTable_parameter" {
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

variable "routeTableAssociation_parameter" {
  description = "routeTableAssociation_parameter"
  type = map(object({
    subnet_name     = string
    routeTable_name = string
  }))

  default = {}
}

