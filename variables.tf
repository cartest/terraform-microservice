variable "user_data_script" {
  type        = "string"
  description = "User data script executed at instance boot"
  default     = ""
}

variable "additional_security_group_ids" {
  type        = "list"
  default     = []
  description = "Additional security groups to assign to ASG instances on top of the unique one created by this module"
}

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

variable "asg_load_balancers" {
  type        = "list"
  default     = []
  description = "A list of load balancer names to add to the autoscaling group names"
}

variable "availability_zones" {
  type        = "list"
  default     = []
  description = "List of Availability Zones for Subnets and Autoscaling Groups"
}

variable "aws_region" {
  type        = "string"
  description = "The AWS region"
  default     = "eu-west-1"
}

variable "lc_ami_id" {
  type        = "string"
  description = "The AMI ID to use in the ASG Launch Configuration"
}

variable "lc_instance_type" {
  type        = "string"
  description = "The microservice EC2 instance type"
}

variable "lc_key_name" {
  type        = "string"
  default     = ""
  description = "The key name that should be used for the instance"
}

variable "load_balancers" {
  type        = "list"
  default     = []
  description = "A list of load balancers to associate to the ASG"
}

variable "name" {
  type        = "string"
  description = "Microservice name. Used to define resource names and Name tags"
}

variable "nodetype" {
  type        = "string"
  description = "Microservice nodetype. Synonymous with Role. Used to populate Role and Nodetype tag."
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

variable "subnets_route_tables" {
  type        = "list"
  description = "List of Route table IDs to associate with the subnets"
  default     = []
}

# Worth considering going back to indiviual variables here.
# All the modules above are populating these from var.project and var.environment,
# and tier is set per microservice invocation
#
# Doing it this way you cannot mandate that Environment, Application and Tier are set
# but we should never create a microservice that doesn't have all three set.
#
# If we *do* go back to individual variables, we just need to change the references
# to this map to individual variables in the code
variable "tags" {
  type = "map"

  default = {
    Environment = ""
    Application = ""
    Tier        = ""
  }

  description = "Tags to apply to all components within the microservice"
}

variable "vpc_id" {
  type        = "string"
  description = "Parent VPC ID"
}

variable "asg_enabled_metrics" {
  description = "A comma seperated list of metrics to apply to the ASG"
  default     = "GroupTerminatingInstances,GroupMaxSize,GroupDesiredCapacity,GroupPendingInstances,GroupInServiceInstances,GroupMinSize,GroupTotalInstances"
}

# This is NOT set in the ASG properties in terraform, it is set at create-time using a local-exec provisioner.
# This ensures that desired size can be changed by schedules and other automation without terraform
# wishing to change the desired value undesirably on subsequent runs.
variable "asg_size_desired_on_create" {
  type        = "string"
  description = "The desired size of the ASG *ON CREATION ONLY*"
  default     = 0
}
# NOTE: Default set to zero so that this code can be used in existing circumstances without a TF error.
