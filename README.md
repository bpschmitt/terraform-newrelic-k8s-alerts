# terraform-newrelic-k8s-alerts

## Install

```
terraform init
terraform plan
terraform apply
```

## Auto-deployed Kubernetes Default Alert Policy

### Data Plane

- ReplicaSet Doesn't Have Desired Number of Pods
- Container Memory Utilization % is Too High
- Container CPU Utilization % is Too High
- Pod unable to be scheduled
- Pod is not ready

### Control Plane

- ETCD Open File Descriptors
- ETCD Has No Leader
- Controller Manager Has No Leader
- Scheduler Has No Leader