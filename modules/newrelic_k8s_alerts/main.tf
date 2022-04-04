terraform {
  required_version = "~> 1.0"
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

locals {
  cluster_name = var.cluster_name
  account_id   = var.account_id
}

resource "newrelic_alert_policy" "newrelic_k8s_policy" {
  name = "Kubernetes Policy - ${local.cluster_name}"
}

resource "newrelic_nrql_alert_condition" "container_cpu_utilization" {

  count = var.enable_pods_containers ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "Container: High CPU Utilization"
  description                    = "Alert when container exceeds its CPU Utilization threshold. (cpuCoresUsed / cpuLimitCores) * 100"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "from K8sContainerSample select max(cpuCoresUtilization) where clusterName = '${local.cluster_name}' facet containerName, podName"
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

resource "newrelic_nrql_alert_condition" "container_memory_utilization" {

  count = var.enable_pods_containers ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "Container: High Memory Utilization"
  description                    = "Alert when container exceeds its Memory Utilization threshold"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "from K8sContainerSample select max(memoryWorkingSetUtilization) where clusterName = '${local.cluster_name}' facet containerName, podName"
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

# Low vs No replicas
resource "newrelic_nrql_alert_condition" "replicaset_desired_pods" {

  count = var.enable_pods_containers ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "ReplicaSet: PodsDesired < PodsReady"
  description                    = "Alert when ReplicaSet does not have correct number of PodsDesired"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true
  slide_by                       = 30

  nrql {
    query = "FROM K8sReplicasetSample select latest(podsDesired) - latest(podsReady) as 'result' where clusterName = '${local.cluster_name}' facet replicasetName, deploymentName"
  }

  critical {
    operator              = "above"
    threshold             = 0
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }
}

resource "newrelic_nrql_alert_condition" "pod_not_ready" {

  count = var.enable_pods_containers ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "Pod is not Ready"
  description                    = "Alert when Pod is not in a Ready state"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true

  nrql {
    query = "FROM K8sPodSample select latest(isReady) where clusterName = '${local.cluster_name}' facet podName"
  }

  critical {
    operator              = "below"
    threshold             = 1
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }
}

resource "newrelic_nrql_alert_condition" "pod_not_scheduled" {

  count = var.enable_pods_containers ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "Pod is not Scheduled"
  description                    = "Alert when Pod is not in able to be Scheduled."
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true

  nrql {
    query = "FROM K8sPodSample select latest(isScheduled) where clusterName = '${local.cluster_name}' facet podName"
  }

  critical {
    operator              = "below"
    threshold             = 1
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }
}

resource "newrelic_nrql_alert_condition" "node_not_ready" {

  count = var.enable_nodes ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "Node is Not Ready"
  description                    = "Alert when node is not ready"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true

  nrql {
    query = "FROM K8sNodeSample select latest(condition.Ready) where clusterName = '${local.cluster_name}' facet nodeName"
  }

  critical {
    operator              = "below"
    threshold             = 1
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }
}

resource "newrelic_nrql_alert_condition" "liveness_probe_failure" {

  count = var.enable_pods_containers ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "Liveness Probe Failed"
  description                    = "Alert when the liveness probe for a container fails"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true

  nrql {
    query = "from InfrastructureEvent select latest(event.count) - earliest(old_event.count) where event.message like '%Liveness probe failed%' and clusterName = '${local.cluster_name}' facet entityName"
  }

  critical {
    operator              = "above"
    threshold             = 1
    threshold_duration    = 120
    threshold_occurrences = "at_least_once"
  }
}

resource "newrelic_nrql_alert_condition" "etcd_open_file_descriptors" {

  count = var.enable_control_plane ? 1 : 0

  account_id                     = local.account_id
  policy_id                      = newrelic_alert_policy.newrelic_k8s_policy.id
  type                           = "static"
  name                           = "ETCD: Open File Descriptors"
  description                    = "Alert when the open file descriptors for ETCD exceed a threshold"
  enabled                        = true
  violation_time_limit_seconds   = 3600
  fill_option                    = "last_value"
  aggregation_window             = 60
  aggregation_method             = "event_flow"
  aggregation_delay              = 60
  expiration_duration            = 60
  open_violation_on_expiration   = true
  close_violations_on_expiration = true

  nrql {
    query = "FROM K8sEtcdSample select max(processOpenFds)/max(processMaxFds)*100 where clusterName = '${local.cluster_name}'"
  }

  critical {
    operator              = "above"
    threshold             = 90
    threshold_duration    = 120
    threshold_occurrences = "ALL"
  }
}