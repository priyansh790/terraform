variable "ec2_parameter" {
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