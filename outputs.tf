output "sns_topic_arn" {
  # get the first topic arn
  value =  module.billing_cloudwatch_alert.sns_topic_arns[0]
}
