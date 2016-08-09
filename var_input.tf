### Module inputs ###

# VPC ID for microservice
variable "vpc_id" {
  type    = "string"
  default = ""
}

# CIDR list for private networks
variable "subnet_cidr_priv" {
  type    = "list"
  default = ""
}

# CIDR list for public networks
variable "subnet_cidr_pub" {
  type    = "list"
  default = ""
}

# List of az for microservice
variable "subnet_availability_zone" {
  type    = "list"
  default = ["eu-west-1a","eu-west-1b","eu-west-1c"]
}

# AMI ID for used for microservice
variable "ami_id" {
  type    = "string"
  default = ""
}

# Instance type for service ( t2.micro :)
variable "instance_type" {
  type    = "string"
  default = ""
}

# Number of ec2 stand alone instances.
# If we set this variable our service will be deployed as stand alone ec2 instance
variable "stand_alone_instance_count" {
  type    = "string"
  default = "0"
}

# Number of instances in autoscaling group
variable "asg_instance_count" {
  type    = "string"
  default = "1"
}

# Assign public ip to ASG
variable "public_ip_toggle" {
  type    = "string"
  default = "0"
}

# Route 53 zone id for Environment
variables "route53_zone_id" {
  type    = "string"
  default = ""
}
