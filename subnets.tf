# Create private subnets for service if defined
resource "aws_subnet" "private_subnets" {
    count                   = "${length(var.subnets_cidr_priv)}"
    vpc_id                  = "${var.vpc_id}"
    cidr_block              = "${var.subnets_cidr_priv[count.index]}"
    availability_zone       = "${element(var.subnets_availability_zones, count.index)}"
    map_public_ip_on_launch = false

    tags {
      Name = "${var.service_tags["name"]}-service-${var.service_tags["environment"]}-private"
    }
}

# Create public subnets for service if defined
resource "aws_subnet" "public_subnets" {
    count                   = "${length(var.subnets_cidr_pub)}"
    vpc_id                  = "${var.vpc_id}"
    cidr_block              = "${var.subnets_cidr_pub[count.index]}"
    availability_zone       = "${element(var.subnets_availability_zones, count.index)}"
    map_public_ip_on_launch = false

    tags {
      Name = "${var.service_tags["name"]}-service-${var.service_tags["environment"]}-public"
    }
}
