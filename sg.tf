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
