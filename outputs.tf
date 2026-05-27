output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "rule_arn" {
  description = "ARN of the EventBridge rule"
  value       = module.rule.arn
}

output "rule_name" {
  description = "Name of the EventBridge rule"
  value       = module.rule.name
}
