---
title: "Cluster config"
date: 2020-12-25T06:00:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Cluster config
    identifier: cluster-config
    parent: Kubeadm
    weight: 10
---

This document shows **kubeadm** usage,

Official document:

> https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/

### Default cluster config

* Master node

   ```
   kubeadm config print init-defaults
   ```

* Worker node

   ```
   kubeadm config print join-defaults
   ```

Once cluster is ready, user can view kubeadm config by following command,

```
kubectl get cm kubeadm-config -o yaml -n kube-system
```

### Customize cluster config

**kubeadm** provides `--config` option for `kubeadm init` and `kubeadm join`, user can configure a cluster by a `yaml` file as following example,

```
kubeadm init/join --config config.yaml
```

for this yaml file, it should follow format [kubeadm/v1beta2/types.go](https://github.com/kubernetes/kubernetes/blob/master/cmd/kubeadm/app/apis/kubeadm/v1beta2/types.go), detail description can refer to [kubeadm config doc](https://github.com/kubernetes/kubernetes/blob/master/cmd/kubeadm/app/apis/kubeadm/v1beta2/doc.go)

**NOTE:** some options are conflict with `--config`, for example `--token`, and user can get error `can not mix '--config' with arguments [token]`, configuring `token` in `--config` yaml file can avoid this problem.

### Specify certification and bootstrap token when init.

1. Generate certificates

   ```
   openssl genrsa -out ca.key 2048
   openssl rand -writerand .rnd
   openssl req -x509 -new -nodes -key ca.key -subj "/CN=$MASTER_IP" -days 10000 -out ca.crt

   cp ca.key /etc/kubernetes/pki
   cp ca.crt /etc/kubernetes/pki
   ```

2. Initialize cluster

   ```
   kubeadm init --token 5uitrl.aiajjpm6mkoouzkk --token-ttl 0 --cert-dir /etc/kubernetes/pki/
   ```

   * since there is no tool for creating a token(kubeadm token can be valid when cluster is running only), it can spcify a token as [token format](https://kubernetes.io/docs/reference/access-authn-authz/bootstrap-tokens/#token-format).

   * `--token-ttl 0` means that token never expire.

   * how to validate certification and bootstrap tooken by Golang can refer to [api.go](../../src/api.go)
