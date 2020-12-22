---
title: "Helm"
date: 2020-12-22T06:00:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Helm
    identifier: kubernetes-helm
    parent: kubernetes
    weight: 10
---

# Helm

### Local helm repository

for preparing a local helm repository, user has to setup follows,

- **ChartMuseum** is an open-source, easy to deploy, Helm Chart Repository server.

  > https://chartmuseum.com/
  > https://github.com/helm/chartmuseum

- **Helm-servecm** is a plugin that help to start ChartMuseum server.

  > https://github.com/jdolitsky/helm-servecm

- **Helm-push** is a helm plugin to push helm chart package to ChartMuseum.

  > https://github.com/chartmuseum/helm-push


#### Install ChartMuseum/Helm-servecm/Helm-push plugins

1. install ChartMuseum/Helm-servecm

   refer to [official installation doc](https://github.com/jdolitsky/helm-servecm#install)

2. install Helm-push

   refer to [official installation doc](https://github.com/chartmuseum/helm-push#install)

#### Usage

1. init a local repository

   ```
   $ helm servecm --port=8080 --storage="local" --storage-local-rootdir="/root/charts"
   2020-06-16T21:09:46.757+0800 INFO    Starting ChartMuseum    {"port": 8080}
   ```

2. add local helm repository

   ```
   $ helm repo add local http://localhost:8080
   $ helm repo list
   NAME         URL
   local        http://localhost:8080
   ```

3. push package into repository

   ```
   $ helm push charts/ros1-demo/ local
   $ helm repo update
   $ helm search repo
   NAME                 CHART VERSION   APP VERSION     DESCRIPTION
   local/ros1-demo      1.0.0           1.0.0           A ROS1 demo chart for Kubernetes
   ```

   then user can install ros1-demo by `helm install`

