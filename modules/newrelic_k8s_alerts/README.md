## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_newrelic"></a> [newrelic](#provider\_newrelic) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [newrelic_alert_policy.newrelic_k8s_policy](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/alert_policy) | resource |
| [newrelic_nrql_alert_condition.container_cpu_utilization](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.container_memory_utilization](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.etcd_open_file_descriptors](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.liveness_probe_failure](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.node_not_ready](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.pod_not_ready](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.pod_not_scheduled](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |
| [newrelic_nrql_alert_condition.replicaset_desired_pods](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/nrql_alert_condition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_id"></a> [account\_id](#input\_account\_id) | New Relic Account ID | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The cluster to create alerts for | `string` | n/a | yes |
| <a name="input_enable_control_plane"></a> [enable\_control\_plane](#input\_enable\_control\_plane) | Enable control plane alerts.  Not applicable for EKS, GKE, AKS.<br><br>    Default: true | `bool` | `false` | no |
| <a name="input_enable_nodes"></a> [enable\_nodes](#input\_enable\_nodes) | Enable node alerts.<br><br>    Default: true | `bool` | `true` | no |
| <a name="input_enable_pods_containers"></a> [enable\_pods\_containers](#input\_enable\_pods\_containers) | Enable pod and container alerts.<br><br>    Default: true | `bool` | `true` | no |

## Outputs

No outputs.
