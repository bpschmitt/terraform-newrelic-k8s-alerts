# output "policy_id" {
#   value = newrelic_alert_policy.newrelic_k8s_policy.id
# }

output "cluster_name" {
  value = var.cluster_name
}

output "account_id" {
  value = var.account_id
}
