output "policy_id" {
  value = newrelic_alert_policy.newrelic_k8s_policy.id
}

output "cluster_name" {
  value = var.cluster_name
}

output "container_cpu_utilization_condition_id" {
  value = newrelic_nrql_alert_condition.container_cpu_utilization.id
}