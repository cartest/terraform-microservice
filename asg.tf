# Create ASG launch configration
resource "aws_launch_configuration" "service_asg_lc" {
    count                       = "${var.enable_asg}"
    name_prefix                 = "${var.service_tags["name"]}-${var.service_tags["environment"]}"
    image_id                    = "${var.ami_id}"
    associate_public_ip_address = "${var.public_ip_toggle}"
    instance_type               = "${var.instance_type}"
    security_groups             = ["sg1","sg2"]
    key_name                    = "${var.ssh_key_name}"
    lifecycle {
        create_before_destroy = true
    }
}


# Create ASG and assing launch configration to it
resource "aws_autoscaling_group" "service_asg" {
  count                = "${var.enable_asg}"
  depends_on           = ["aws_launch_configuration.service_asg_lc"]
  name                 = "asg-${var.service_tags["environment"]}-${var.service_tags["name"]}"
  availability_zones   = "${var.subnets_availability_zones}"
  launch_configuration = "${aws_launch_configuration.service_asg_lc.id}"
  max_size             = "${var.asg_instance_count}"
  min_size             = "${var.asg_instance_count}"
  vpc_zone_identifier  = ["${aws_subnet.private_subnets.*.id}"]

  tag = {
    key                 = "Name"
    value               = "${var.service_tags["name"]}-${var.service_tags["environment"]}-${var.ami_id}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Environment"
    value               = "${var.service_tags["environment"]}"
    propagate_at_launch = true
  }
}
