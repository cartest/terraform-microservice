module "subnets" {
  source                  = "../terraform-subnet-tuple"
  route_tables            = "${var.subnets_route_tables}"
  availability_zones      = "${var.availability_zones}"
  tags                    = "${var.tags}"
  map_public_ip_on_launch = "${var.subnets_map_public_ip_on_launch}"
  cidrs                   = "${var.subnets_cidr}"
  name                    = "${var.name}"
  aws_region              = "${var.aws_region}"
  vpc_id                  = "${var.vpc_id}"
}
