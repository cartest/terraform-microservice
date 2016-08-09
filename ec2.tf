# Create stand alone ec2 instances if defined
resource "aws_instance" "service_instance" {
  count                       = "${var.stand_alone_instance_count}"
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.public_ip_toggle}"
  # vpc_security_group_ids      = ["${aws_security_group.generic.id}", "${var.app_security_groups}"]
  subnet_id                   = "${element(aws_subnet.private_subnets.*.id, count.index)}"
  availability_zone           = "${element(var.subnets_availability_zones, count.index)}"
  key_name                    = "${var.ssh_key_name}"

  tags {
    Name        = "${var.service_tags["name"]}-${var.service_tags["environment"]}-${count.index + 1}"
    Environment = "${var.service_tags["environment"]}"
  }
}
