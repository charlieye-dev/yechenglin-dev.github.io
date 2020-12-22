---
title: "Taint manager eviction"
date: 2020-12-22T06:00:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Taint manager eviction
    identifier: kubernetes-taint-manager-eviction
    parent: kubernetes
    weight: 10
---

# Taint Based Eviction

> https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/#taint-based-evictions

For current kubernetes, Taint based Evictions support as follows,

- tolerations `node.kubernetes.io/not-ready:NoExecute for 300s` and `node.kubernetes.io/unreachable:NoExecute for 300s` are marked on pods in default by k8s when deploy, it means that pods can tolerate these taints for 300s.

  ```
  $ kubectl describe po my-pod-787f46887-cx2gt | grep -i node
  Node:            edge/192.168.0.4
  Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                   node.kubernetes.io/unreachable:NoExecute for 300s
  ```

- once a slave node was disconnected from cluster, taints `node.kubernetes.io/unreachable:NoExecute` and `node.kubernetes.io/unreachable:NoSchedule` will be marked on the lost node by controller-manager after `--node-monitor-grace-period`(it can be configured in /etc/kubernetes/manifests/kube-controller-manager.yaml) timeout, it means that all pods on slave must be evicted if no toleration.

  ```
  $ kubectl describe node edge | grep -i node
  Annotations:        node.alpha.kubernetes.io/ttl: 0
  Taints:             node.kubernetes.io/unreachable:NoExecute
                      node.kubernetes.io/unreachable:NoSchedule
  ```

Based on this feature, user can control eviction timeout easily, for example,

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-pod
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pod
  template:
    metadata:
      labels:
        app: pod
    spec:
      containers:
      - image: ubuntu:18.04
        command: ["/bin/bash", "-c", "while true; do date && sleep 30; done"]
        imagePullPolicy: IfNotPresent
        name: app
      restartPolicy: Always
      nodeSelector:
        nodetype: slave
      tolerations:
      - key: "node.kubernetes.io/unreachable"
        operator: "Exists"
        effect: "NoExecute"
        tolerationSeconds: 10s
```

`tolerationSeconds` specified how long this pod can tolerate taint `node.kubernetes.io/unreachable:NoExecute`, it means that this pod can tolerate taint `node.kubernetes.io/unreachable:NoExecute` 10s, after timeout, this pod will be evicted from this node.

if user want to keep pod running and never reschedule on a lost node with never eviction, just not specify `tolerationSeconds`.
