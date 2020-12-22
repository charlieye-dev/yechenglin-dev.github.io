---
title: "Kubelet"
date: 2020-12-22T06:00:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Kubelet
    identifier: kubernetes-kubelet
    parent: kubernetes
    weight: 10
---

# Kubelet

This document provides some tips of using kubelet.

Official documents:

> https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/


## Tips

1. Since all slave nodes have no capability of storing in kubernetes, it means that kubelet has to request api-server in period.

2. Once slave node was registered to cluster, it no way reconfigure some features by restarting kubelet, for example labeling node by `--node-label` option when start kubelet. However, if slave node is deleted by administrator(kubectl delete node $NODE_NAME) from cluster, slave node can rejoin cluster by restarting cluster, also some reconfigurable features will active.
