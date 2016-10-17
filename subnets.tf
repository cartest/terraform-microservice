module "subnets" {
  source                  = "github.com/cartest/terraform-subnet-tuple.git?ref=story-OPSTEAM-228"
  availability_zones      = "${var.availability_zones}"
  aws_region              = "${var.aws_region}"
  cidrs                   = "${var.subnets_cidr}"
  map_public_ip_on_launch = "${var.subnets_map_public_ip_on_launch}"
  name                    = "${var.name}"
  route_tables            = "${var.subnets_route_tables}"
  tags                    = "${var.tags}"
  vpc_id                  = "${var.vpc_id}"
}
