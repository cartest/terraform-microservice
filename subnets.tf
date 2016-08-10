# Create private subnets for service if defined
resource "aws_subnet" "subnets" {
  count                   = "${length(var.subnets_cidr)}"
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.subnets_cidr[count.index]}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = "${var.subnets_map_public_ip_on_launch}"

  tags {
    # Tagging policy requests ${element(var.availability_zones, count.index)} be converted into "EW/1A" style
    # We can look this up, or we can suggest that this format is not optimal
    Name = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-SUB-${element(var.availability_zones, count.index)}"

    # Can we just inherit the master tags list from var_input.tf here?
    Environment = "${var.tags["Environment"]}"
    Application = "${var.tags["Application"]}"
    Tier        = "${var.tags["Tier"]}"
    Role        = "${var.name}"
  }
}

resource "aws_route_table_association" "route_table_associations" {
  count          = "${length(var.subnets_cidr)}"
  subnet_id      = "${element(aws_subnet.subnets.*.id, count.index)}"
  route_table_id = "${var.subnets_route_table_id}"
}
