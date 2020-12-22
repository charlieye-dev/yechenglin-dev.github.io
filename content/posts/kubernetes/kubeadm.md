---
title: "Kubeadm"
date: 2020-12-22T06:00:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Kubeadm
    identifier: kubernetes-kubeadm
    parent: kubernetes
    weight: 10
---

# Kubeadm

This document shows some usages of kubeadm.

Official document:

> https://kubernetes.io/docs/reference/setup-tools/kubeadm/kubeadm/

### Specify certifications and token when kubeadm init.

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

   since there is no tool for creating a token(kubeadm token can be valid when cluster is running only), it can spcify a token as [token format](https://kubernetes.io/docs/reference/access-authn-authz/bootstrap-tokens/#token-format).

   `--token-ttl 0` means that token never expire.
