---
title: "Registry name format"
date: 2020-12-25T13:26:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Registry name format
    identifier: docker-registry-format
    parent: Docker
    weight: 10
---

**Q:** When doing a docker push or when pulling an image, how does Docker determine if there is a registry server in the image name or if it is a path/username on the default registry (e.g. Docker Hub)?

**A:** The hostname must contain a `.` dns separator or a `:` port separator before the first `/`, otherwise the code assumes you want the default registry(`docker.io`).

Detail **Q&A** can refer following,

> https://stackoverflow.com/questions/37861791/how-are-docker-image-names-parsed
