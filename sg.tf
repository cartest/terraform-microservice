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

resource "aws_security_group_rule" "cb_ingress" {
  count                    = "${length(var.sg_cb_ingress_rule)}"
  type                     = "ingress"
  cidr_blocks              = ["${split(",",lookup(var.sg_cb_ingress_rule[count.index],"cidr_blocks"))}"]
  protocol                 = "${lookup(var.sg_cb_ingress_rule[count.index],"protocol")}"
  from_port                = "${lookup(var.sg_cb_ingress_rule[count.index],"from_port")}"
  to_port                  = "${lookup(var.sg_cb_ingress_rule[count.index],"to_port")}"
  security_group_id        = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "ssg_ingress" {
  count                    = "${length(var.sg_ssg_ingress_rule)}"
  type                     = "ingress"
  source_security_group_id = "${lookup(var.sg_ssg_ingress_rule[count.index],"source_sg_id")}"
  protocol                 = "${lookup(var.sg_ssg_ingress_rule[count.index],"protocol")}"
  from_port                = "${lookup(var.sg_ssg_ingress_rule[count.index],"from_port")}"
  to_port                  = "${lookup(var.sg_ssg_ingress_rule[count.index],"to_port")}"
  security_group_id        = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "pl-cb_egress" {
  count             = "${length(var.sg_pl_cb_egress_rule)}"
  type              = "egress"
  cidr_blocks       = ["${compact(split(",",lookup(var.sg_pl_cb_egress_rule[count.index],"cidr_blocks")))}"]
  prefix_list_ids   = ["${compact(split(",",lookup(var.sg_pl_cb_egress_rule[count.index],"prefix_list_ids")))}"]
  protocol          = "${lookup(var.sg_pl_cb_egress_rule[count.index],"protocol")}"
  from_port         = "${lookup(var.sg_pl_cb_egress_rule[count.index],"from_port")}"
  to_port           = "${lookup(var.sg_pl_cb_egress_rule[count.index],"to_port")}"
  security_group_id = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "pl-ssg_egress" {
  count                    = "${length(var.sg_pl_ssg_egress_rule)}"
  type                     = "egress"
  source_security_group_id = "${lookup(var.sg_pl_ssg_egress_rule[count.index],"source_sg_id")}"
  prefix_list_ids          = ["${compact(split(",",lookup(var.sg_pl_ssg_egress_rule[count.index],"prefix_list_ids")))}"]
  protocol                 = "${lookup(var.sg_pl_ssg_egress_rule[count.index],"protocol")}"
  from_port                = "${lookup(var.sg_pl_ssg_egress_rule[count.index],"from_port")}"
  to_port                  = "${lookup(var.sg_pl_ssg_egress_rule[count.index],"to_port")}"
  security_group_id        = "${aws_security_group.security_group.id}"
}
