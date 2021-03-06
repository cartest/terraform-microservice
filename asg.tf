# Create launch configration
resource "aws_launch_configuration" "launch_configuration" {
  name_prefix          = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-LC/"
  image_id             = "${var.lc_ami_id}"
  instance_type        = "${var.lc_instance_type}"
  security_groups      = ["${concat(split(",", aws_security_group.security_group.id), var.additional_security_group_ids)}"]
  iam_instance_profile = "${aws_iam_instance_profile.iam_instance_profile.id}"
  user_data            = "${var.user_data_script}"

  lifecycle {
    create_before_destroy = true
  }
}

# Create ASG and assing launch configration to it
resource "aws_autoscaling_group" "autoscaling_group" {
  name                 = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-ASG"
  launch_configuration = "${aws_launch_configuration.launch_configuration.id}"
  max_size             = "${var.asg_size_max}"
  min_size             = "${var.asg_size_min}"
  vpc_zone_identifier  = ["${module.subnets.subnet_ids}"]
  load_balancers       = ["${var.load_balancers}"]

  enabled_metrics = ["${split(",", var.asg_enabled_metrics)}"]

  tag = {
    key                 = "Name"
    value               = "${var.name}-${var.tags["Environment"]}-${var.lc_ami_id}"
    propagate_at_launch = true
  }

  # Legacy tag currently used. To be replaced by "Role" in the future.
  tag = {
    key                 = "nodetype"
    value               = "${var.nodetype}"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Role"
    value               = "${var.nodetype}"
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

  provisioner "local-exec" {
    command = "aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${aws_autoscaling_group.autoscaling_group.name} --desired-capacity ${var.asg_size_desired_on_create}"
  }
}
