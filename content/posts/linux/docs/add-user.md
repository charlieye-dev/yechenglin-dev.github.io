---
title: "Add user"
date: 2020-12-25T10:50:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Add user
    identifier: linux-add-user
    parent: Linux
    weight: 10
---

1. create a user with *home* dir

    ```
    useradd -m testuser
    ```

2. create a password for user

    ```
    passwd testuser
    ```

3. modify user account

    ```
    usermod -aG sudo -s /bin/bash testuser
    ```

    it means append `testuser` to `sudo` Group, and bash used for this user.


