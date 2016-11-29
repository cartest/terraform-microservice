resource "aws_autoscaling_attachment" "asg_attachment" {
  count = "${length(var.load_balancer_ids})"
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.id}"
  elb                    = "${element(var.load_balancer_ids,count.index)}"
}
