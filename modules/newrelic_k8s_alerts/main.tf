terraform {
  required_version = "~> 1.0"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}

resource "newrelic_alert_policy" "newrelic_k8s_policy" {
	name = "Kubernetes Policy - ${var.cluster_name}"
}

resource "newrelic_nrql_alert_condition" "container_cpu_utilization" {
  account_id                     = var.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "Container CPU Utilization"
  description                    = "Alert when container exceeds its CPU Utilization threshold. (cpuCoresUsed / cpuLimitCores) * 100"
#   runbook_url                    = "https://www.example.com"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
#   fill_value                     = 1.0
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "from K8sContainerSample select max(cpuCoresUtilization) where clusterName = '${var.cluster_name}' facet containerName, podName"
  }

  critical {
    operator              = "above"
    threshold             = 85
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }

  warning {
    operator              = "above"
    threshold             = 70
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }
}