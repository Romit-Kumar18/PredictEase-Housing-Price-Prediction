resource "aws_iam_policy_attachment" "ecs_policy_attach" {
  name = "ecs-policy-attachment"
  roles = [ aws_iam_role.ecs_instance_role.name ]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_policy_attachment" "cloudwatch_logs_attach" {
  name = "cloudwatch-logs-attachment"
  roles = [ aws_iam_role.ecs_instance_role.name ]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}