# terraform-newrelic-k8s-alerts

## Initialize module

```
terraform init
```

## Deploy

Copy `terraform.tfvars.example` to `terraform.tfvars` and updated the variables with the following info:

- New Relic Account ID
- New Relic User API Key
- New Relic Cluster Name

```
terraform plan
terraform apply
```

## Auto-deployed Kubernetes Default Alert Policy

### Data Plane

- [x] ReplicaSet Doesn't Have Desired Number of Pods
- [x] Container Memory Utilization % is Too High
- [x] Container CPU Utilization % is Too High
- [x] Pod unable to be scheduled
- [x] Pod is not ready

### Control Plane

- [x] ETCD Open File Descriptors
- [x] ETCD Has No Leader
- Controller Manager Has No Leader
- Scheduler Has No Leader