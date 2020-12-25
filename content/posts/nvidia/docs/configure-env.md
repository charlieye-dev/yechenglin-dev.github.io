---
title: "Configure Development Environment"
date: 2020-12-22T06:00:20+06:00
#hero: /images/posts/writing-posts/git.svg
menu:
  sidebar:
    name: Configure Development Environment
    identifier: nvidia-env
    parent: nvidia
    weight: 10
---

This document describes how to setup NVIDIA full development environment under ubuntu-18.04.

## Install NVIDIA driver

1. Choose corresponding driver version based on your card series

   > https://www.nvidia.co.jp/Download/index.aspx

   then, download it.

2. Run installation script

   ```
   $ sudo bash NVIDIA-Linux-x86_64-440.82.run
   ```

   **NOTE:** ensure that `make`, `gcc` and `libc header files` have been installed in previous, if not, install them as follows,

   ```
   $ sudo apt-get install gcc make build-essential linux-headers-`uname -r` --no-install-recommends
   ```

3. Reboot

   ```
   $ sudo reboot
   ```

4. Check installation result

   ```
   $ nvidia-smi
   Sat May 16 00:31:38 2020
   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 440.82       Driver Version: 440.82       CUDA Version: 10.2     |
   |-------------------------------+----------------------+----------------------+
   | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   |===============================+======================+======================|
   |   0  GeForce RTX 207...  Off  | 00000000:01:00.0  On |                  N/A |
   |  0%   52C    P0    51W / 215W |    171MiB /  7979MiB |      0%      Default |
   +-------------------------------+----------------------+----------------------+

   +-----------------------------------------------------------------------------+
   | Processes:                                                       GPU Memory |
   |  GPU       PID   Type   Process name                             Usage      |
   |=============================================================================|
   |    0      1010      G   /usr/lib/xorg/Xorg                            18MiB |
   |    0      1074      G   /usr/bin/gnome-shell                          49MiB |
   |    0      1348      G   /usr/lib/xorg/Xorg                            53MiB |
   |    0      1493      G   /usr/bin/gnome-shell                          43MiB |
   |    0      1803      G   ...gnome-initial-setup/gnome-initial-setup     2MiB |
   +-----------------------------------------------------------------------------+
   ```

## Install CUDA

Refer to official document,

> https://developer.nvidia.com/cuda-downloads

## Install Nvidia docker

Refer to official document,

> https://github.com/NVIDIA/nvidia-docker#ubuntu-160418042004-debian-jessiestretchbuster

then check [nvidia docker usage](https://github.com/NVIDIA/nvidia-docker#usage)
