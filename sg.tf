resource "aws_security_group" "security_group" {
  name        = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-SG"
  description = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-SG"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-SG"
    Environment = "${var.tags["Environment"]}"
    Application = "${var.tags["Application"]}"
    Tier        = "${var.tags["Tier"]}"
    Role        = "${var.name}"
  }
}

resource "aws_security_group_rule" "self_ingress" {
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
  security_group_id = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "self_egress" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
  security_group_id = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "s3_endpoint_access" {
  count             = "${var.s3_endpoint_prefix_list_id == "" ? 0 : 1}"
  type              = "egress"
  protocol          = "-1"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.security_group.id}"
  prefix_list_ids   = ["${var.s3_endpoint_prefix_list_id}"]
}
