output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}

output "security_group_name" {
  value = "${aws_security_group.security_group.name}"
}

output "launch_configuration_id" {
  value = "${aws_launch_configuration.launch_configuration.id}"
}

output "autoscaling_group_id" {
  value = "${aws_autoscaling_group.autoscaling_group.id}"
}

output "autoscaling_group_name" {
  value = "${aws_autoscaling_group.autoscaling_group.name}"
}

output "iam_instance_profile_id" {
  value = "${aws_iam_instance_profile.iam_instance_profile.id}"
}

output "iam_instance_profile_arn" {
  value = "${aws_iam_instance_profile.iam_instance_profile.arn}"
}

output "iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.iam_instance_profile.name}"
}

output "iam_instance_profile_unique_id" {
  value = "${aws_iam_instance_profile.iam_instance_profile.unique_id}"
}

output "iam_role_arn" {
  value = "${aws_iam_role.iam_role.arn}"
}

output "iam_role_unique_id" {
  value = "${aws_iam_role.iam_role.unique_id}"
}

output "iam_role_name" {
  value = "${aws_iam_role.iam_role.name}"
}

output "subnet_ids" {
  value = "${module.subnets.subnet_ids}"
}
