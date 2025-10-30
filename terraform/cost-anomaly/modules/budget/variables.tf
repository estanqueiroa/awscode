
variable "budget_name" {
  description = "Name of the budget"
  type        = string

}

variable "frequency" {
  description = "The frequency that anomaly reports are sent"
  type        = string

}

variable "time_unit" {
  description = "The time unit for budget report"
  type        = string

}

variable "subscriber_type" {
  description = "Subscriber type for anomaly detection"
  type        = string

}



variable "limit_amount" {
  description = "The amount of cost or usage being measured for a budget"
  type        = string

}

variable "time_period_end" {
  description = "The end of the time period covered by the budget"
  type        = string

}

variable "time_period_start" {
  description = "The start of the time period covered by the budget"
  type        = string

}


variable "global_tags" {
  description = "Map of AWS tags to apply to all the created resources."
  type        = map(any)
}

variable "email_address" {
  type = string
}

variable "anomaly_percentage" {
  description = "The threshold value for the anomaly detection in percentage amount"
  type        = number


}


variable "anomaly_absolute" {
  description = "The threshold value for the anomaly detection in absolute amount"
  type        = number



}

