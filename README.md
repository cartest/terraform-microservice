# terraform-microservice
Microservice terraform module

## Example usage:

### api microservice

```terraform
module "microservice_api" {
  source                          = "github.com/cartest/terraform-microservice.git"
  asg_health_check_grace_period   = "300"
  asg_health_check_type           = "EC2"
  asg_size_max                    = "3"
  asg_size_min                    = "3"
  asg_termination_policies        = ["OldestLaunchConfiguration","ClosestToNextInstanceHour"]
  availability_zones              = ["${var.aws_region}a","${var.aws_region}b","${var.aws_region}c"]
  aws_region                      = "${var.aws_region}"
  iam_policy_arns                 = ["${aws_iam_policy.api.arn}","${aws_iam_policy.ec2_default.arn}"]
  lc_ami_id                       = "ami-00000000000000000"
  lc_instance_type                = "t2.micro"
  load_balancers                  = ["${aws_elb.api.id}"]
  name                            = "api"
  subnets_cidr                    = ["10.10.10.1/24","10.10.10.2/24","10.10.10.3/24"]
  subnets_map_public_ip_on_launch = false
  subnets_route_table_id          = "${aws_route_table.private-nat.id}"
  vpc_id                          = "${var.vpc_id}"

  tags {
    Environment = "${var.environment}"
    Application = "${var.project}"
    Tier        = "(PUB|PRI)"
  }
}
```
