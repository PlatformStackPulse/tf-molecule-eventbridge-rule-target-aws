# Molecule: EventBridge Rule with Target
module "rule" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-eventbridge-rule-aws.git?ref=5e7a4a3c9bbce659af1cda9b5f8251efb5bf0520"

  context             = module.this.context
  description         = var.description
  event_bus_name      = var.event_bus_name
  event_pattern       = var.event_pattern
  schedule_expression = var.schedule_expression
  rule_state          = var.rule_state
}

module "target" {
  source = "git::https://github.com/PlatformStackPulse/tf-atom-eventbridge-target-aws.git?ref=f09bcda9b1efd814b65e5737f89c7510bf00bd4a"

  context                      = module.this.context
  rule_name                    = module.rule.name
  event_bus_name               = var.event_bus_name
  target_arn                   = var.target_arn
  role_arn                     = var.role_arn
  input                        = var.input
  input_path                   = var.input_path
  dead_letter_arn              = var.dead_letter_arn
  maximum_retry_attempts       = var.maximum_retry_attempts
  maximum_event_age_in_seconds = var.maximum_event_age_in_seconds

  depends_on = [module.rule]
}
