resource "aws_iam_instance_profile" "iam_instance_profile" {
<<<<<<< HEAD
  name  = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-IAMIP"
=======
  name  = "${var.tags["Environment"]}-${var.tags["Application"]}-${var.tags["Tier"]}-${var.name}-${var.app_stack_identifier}-IAMIP"
>>>>>>> 7f7d0dbb1d52f31442d25dec2f7789e82eb142cd
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
