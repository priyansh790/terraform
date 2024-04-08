variable "securityGroup_parameter" {
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