module "billing_cloudwatch_alert" {
  source  = "binbashar/cost-billing-alarm/aws"

  aws_env = "${var.aws_profile}"
  aws_account_id = "${var.aws_account_id}"
  monthly_billing_threshold = 20
  currency = "USD"
}

# subscribe to the topic
resource "aws_sns_topic_subscription" "billing_alarm_subscription" {
  topic_arn = module.billing_cloudwatch_alert.sns_topic_arns[0]
  protocol = "email"
  endpoint = "${var.endpoint_email}"
}
