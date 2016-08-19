resource "aws_launch_configuration" "launch_configuration" {
  name_prefix          = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-LC/"
  image_id             = "${var.lc_ami_id}"
  instance_type        = "${var.lc_instance_type}"
  security_groups      = ["${aws_security_group.security_group.id}", "${var.additional_security_group_ids}"]
  key_name             = "${var.lc_key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile.id}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-ASG"
  launch_configuration      = "${aws_launch_configuration.launch_configuration.id}"
  max_size                  = "${var.asg_size_max}"
  min_size                  = "${var.asg_size_min}"
  vpc_zone_identifier       = ["${module.subnets.subnet_ids}"]
  termination_policies      = ["${asg_termination_policies}"]
  health_check_grace_period = "${asg_health_check_grace_period}"
  tag = {
    key                 = "Name"
    value               = "${var.name}-${var.tags["Environment"]}-${var.lc_ami_id}"
    propagate_at_launch = true
  }
  # Legacy tag currently used. To be replaced by "Role" in the future.
  tag = {
    key                 = "nodetype"
    value               = "${var.name}"
    propagate_at_launch = true
  }
  tag = {
    key                 = "Environment"
    value               = "${var.tags["Environment"]}"
    propagate_at_launch = true
  }
  tag = {
    key                 = "Application"
    value               = "${var.tags["Application"]}"
    propagate_at_launch = true
  }
  tag = {
    key                 = "Tier"
    value               = "${var.tags["Tier"]}"
    propagate_at_launch = true
  }
  tag = {
    key                 = "Role"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}
