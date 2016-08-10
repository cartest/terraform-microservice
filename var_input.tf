### Module inputs ###

variable "asg_health_check_grace_period" {
  type        = "string"
  default     = "300"
  description = "Time (in seconds) after instance comes into service before checking health"
}

variable "asg_health_check_type" {
  type        = "string"
  default     = "EC2"
  description = "'EC2' or 'ELB'. Controls how health checking is done"
}

variable "asg_size_max" {
  type        = "string"
  default     = "1"
  description = "The maximum size of the autoscaling group"
}

variable "asg_size_min" {
  type        = "string"
  default     = "1"
  description = "The minimum size of the autoscaling group"
}

variable "asg_termination_policies" {
  type        = "list"
  default     = ["OldestLaunchConfiguration", "ClosestToNextInstanceHour"]
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
}

variable "availability_zones" {
  type        = "list"
  default     = []
  description = "List of Availability Zones for Subnets and Autoscaling Groups"
}

variable "aws_region" {
  type        = "string"
  description = "The AWS region"
}

variable "iam_policies" {
  type        = "list"
  default     = []
  description = "A list of IAM policies to associate with the EC2 role used to create EC2 instance profiles"
}

variable "lc_ami_id" {
  type        = "string"
  default     = ""
  description = "The AMI ID to use in the ASG Launch Configuration"
}

variable "lc_instance_type" {
  type        = "string"
  description = "The microservice EC2 instance type"
}

variable "load_balancers" {
  type        = "list"
  default     = []
  description = "A list of load balancers to associate to the ASG"
}

variable "name" {
  type        = "string"
  description = "Microservice name"
}

variable "subnets_cidr" {
  type        = "list"
  default     = []
  description = "List of CIDR blocks for microservice subnets"
}

variable "subnets_map_public_ip_on_launch" {
  type        = "string"
  default     = "0"
  description = "Specify true to indicate that instances should be assigned a public IP address"
}

variable "subnets_route_table_id" {
  type        = "string"
  description = "Route table ID to associate with the subnets"
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Tags to apply to all components within the microservice"
}

variable "vpc_id" {
  type        = "string"
  description = "Parent VPC ID"
}
