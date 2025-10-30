


variable "budget_name" {
  description = "Name of the budget"
  type        = string

}

variable "limit_amount" {
  description = "The amount of cost or usage being measured for a budget"
  type        = string

}

variable "frequency" {
  description = "The frequency that anomaly reports are sent. Daily or weekly frequencies only support Email subscriptions"
  type        = string
  validation {
    condition     = contains(["DAILY", "IMMEDIATE", "WEEKLY"], var.frequency)
    error_message = "Valid values for var: frequency are (DAILY,IMMEDIATE,WEEKLY)."
  }
}

variable "time_unit" {
  description = "The time unit for budget report"
  type        = string
  validation {
    condition     = contains(["DAILY", "MONTHLY", "QUARTERLY"], var.time_unit)
    error_message = "Valid values for var: time_unit are (DAILY,MONTHLY,QUARTERLY)."
  }
}

variable "subscriber_type" {
  description = "The type of anomaly subscription. Daily or weekly frequencies only support Email subscriptions"
  type        = string
  validation {
    condition     = contains(["EMAIL", "SNS"], var.subscriber_type)
    error_message = "Valid values for var: subscriber_type are (EMAIL,SNS)."
  }
}

variable "time_period_end" {
  description = "The end of the time period covered by the budget"
  type        = string
  #default     = "2087-06-15_00:00"
}

variable "time_period_start" {
  description = "The start of the time period covered by the budget"
  type        = string
  #default     = "2022-02-01_00:00"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "email_address" {
  type = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.email_address))
    error_message = "Please provide a valid email address."
  }
}


variable "anomaly_percentage" {
  description = "The threshold value for the anomaly detection in percentage amount"
  type        = number


  # Optional: Add validation
  validation {
    condition     = var.anomaly_percentage > 0
    error_message = "The anomaly threshold must be a positive number."
  }
}


variable "anomaly_absolute" {
  description = "The threshold value for the anomaly detection in absolute amount"
  type        = number


  # Optional: Add validation
  validation {
    condition     = var.anomaly_absolute > 0
    error_message = "The anomaly threshold must be a positive number."
  }
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources."
  default     = {}
}

