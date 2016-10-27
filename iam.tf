resource "aws_iam_instance_profile" "iam_instance_profile" {
  name  = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-IAMIP"
  roles = ["${aws_iam_role.iam_role.name}"]
}

resource "aws_iam_role" "iam_role" {
  name               = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-IAMROLE"
  assume_role_policy = "${data.template_file.assume_role_policy.rendered}"
}

data "template_file" "assume_role_policy" {
  template = "${file("${path.module}/templates/assume_role_policy.json.tmpl")}"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  count      = "${length(var.iam_policy_arns)}"
  role       = "${aws_iam_role.iam_role.name}"
  policy_arn = "${var.iam_policy_arns[count.index]}"
}
