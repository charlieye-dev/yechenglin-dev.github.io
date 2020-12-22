---
title: "Configure wifi on ubuntu"
date: 2020-12-22T06:00:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Configure wifi on ubuntu
    identifier: linux-wifi
    parent: linux
    weight: 10
---

1. configure wifi information.

    ```
    ubuntu@ubuntu:~$ cat /etc/wpa_supplicant/wpa_supplicant.conf
    netwokr={
       ssid="cicso"
       psk="ubunut12345"
    }
    ```

2. specify configure file and network interface.

    ```
    ubuntu@ubuntu:~$ cat /lib/systemd/system/wpa_supplicant.service
    .....
    [Service]
    ExecStart=/sbin/wpa_supplicant -u -s -o /run/wpa_supplicant/ -c /etc/wpa_supplicant/wpa_supplicant.conf -i wlan0
    .....
    ```

