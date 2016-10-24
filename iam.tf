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
  count      = "1"
  role       = "${aws_iam_role.iam_role.name}"
  policy_arn = "${var.iam_policy_arns[count.index]}"
}

/*resource "aws_iam_role_policy" "instances_descriptions" {
    name = "instances_descriptions_policy"
    role = "${aws_iam_role.iam_role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1476829996485",
            "Action": [
                "ec2:DescribeInstanceAttribute",
                "ec2:DescribeInstanceStatus",
                "ec2:DescribeInstances"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "Stmt1476828750767",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}*/
