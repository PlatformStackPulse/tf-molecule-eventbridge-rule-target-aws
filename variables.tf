variable "description" {
  description = "Description of the EventBridge rule"
  type        = string
  default     = null
}

variable "event_bus_name" {
  description = "Name of the event bus"
  type        = string
  default     = "default"
}

variable "event_pattern" {
  description = "Event pattern JSON"
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "Schedule expression (e.g., rate(1 hour))"
  type        = string
  default     = null
}

variable "rule_state" {
  description = "State of the rule (ENABLED or DISABLED)"
  type        = string
  default     = "ENABLED"
}

variable "target_arn" {
  description = "ARN of the target resource"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN for EventBridge to assume"
  type        = string
  default     = null
}

variable "input" {
  description = "JSON input to pass to the target"
  type        = string
  default     = null
}

variable "input_path" {
  description = "JSONPath to extract from the event"
  type        = string
  default     = null
}

variable "dead_letter_arn" {
  description = "ARN of the SQS queue for dead letters"
  type        = string
  default     = null
}

variable "maximum_retry_attempts" {
  description = "Maximum retry attempts"
  type        = number
  default     = null
}

variable "maximum_event_age_in_seconds" {
  description = "Maximum age of event in seconds"
  type        = number
  default     = null
}
