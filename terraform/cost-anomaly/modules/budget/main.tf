

resource "aws_budgets_budget" "total_cost" {
  name              = var.budget_name
  budget_type       = "COST"
  limit_amount      = var.limit_amount
  limit_unit        = "USD"
  time_period_end   = var.time_period_end
  time_period_start = var.time_period_start
  time_unit         = var.time_unit

  tags = var.global_tags
}

resource "aws_ce_anomaly_monitor" "service_monitor" {
  name              = "${var.budget_name}-service-monitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"

  tags = var.global_tags
}


resource "aws_ce_anomaly_subscription" "alert_absolute" {
  name = "cost-anomaly-alert-absolute"

  frequency = var.frequency

  monitor_arn_list = [
    aws_ce_anomaly_monitor.service_monitor.arn
  ]


  # Daily or weekly frequencies only support Email subscriptions

  subscriber {
    type    = var.subscriber_type
    address = var.subscriber_type == "SNS" ? aws_sns_topic.cost_anomaly_updates[0].arn : var.email_address
  }

  threshold_expression {
    dimension {
      key           = "ANOMALY_TOTAL_IMPACT_ABSOLUTE"
      match_options = ["GREATER_THAN_OR_EQUAL"]
      values        = [tostring(var.anomaly_absolute)]
    }

  }

  tags = var.global_tags

}


resource "aws_ce_anomaly_subscription" "alert_percentage" {
  name = "cost-anomaly-alert-percentage"

  frequency = var.frequency

  monitor_arn_list = [
    aws_ce_anomaly_monitor.service_monitor.arn
  ]

  # Daily or weekly frequencies only support Email subscriptions

  subscriber {
    type    = var.subscriber_type
    address = var.subscriber_type == "SNS" ? aws_sns_topic.cost_anomaly_updates[0].arn : var.email_address
  }

  threshold_expression {
    dimension {
      key           = "ANOMALY_TOTAL_IMPACT_PERCENTAGE"
      match_options = ["GREATER_THAN_OR_EQUAL"]
      values        = [tostring(var.anomaly_percentage)]
    }

  }

  depends_on = [
    aws_sns_topic_policy.default
  ]

  tags = var.global_tags

}




