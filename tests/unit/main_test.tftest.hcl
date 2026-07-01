# Unit tests for tf-molecule-eventbridge-rule-target-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Assertions target plan-KNOWN values only (tf-label id, input pass-throughs).
# Computed ARNs/IDs are unknown under a mock provider, so they are not asserted.
#
# Run with:  terraform test -test-directory=tests/unit

mock_provider "aws" {}

variables {
  # tf-label context inputs
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # Module's own required input
  target_arn = "arn:aws:lambda:us-east-1:123456789012:function:eg-test-thing"

  # Representative optional input
  event_pattern = "{\"source\":[\"aws.s3\"],\"detail-type\":[\"Object Created\"]}"
}

# ---------------------------------------------------------------------------
# When enabled, the module composes the rule + target and the label id
# resolves to the expected known string.
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should be enabled by default"
  }

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should resolve to 'eg-test-thing'"
  }

  assert {
    condition     = module.this.enabled == true
    error_message = "Label context should report enabled"
  }
}

# ---------------------------------------------------------------------------
# A scheduled rule (schedule_expression instead of event_pattern) plans
# cleanly and keeps the label id / enabled flag known.
# ---------------------------------------------------------------------------
run "creates_scheduled_rule" {
  command = plan

  variables {
    event_pattern       = null
    schedule_expression = "rate(1 hour)"
  }

  assert {
    condition     = output.enabled == true
    error_message = "Scheduled rule module should be enabled"
  }

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should resolve to 'eg-test-thing' for scheduled rule"
  }
}
