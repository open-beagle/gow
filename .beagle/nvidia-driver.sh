#!/bin/bash
set -e

mkdir -p .tmp/nvidia

NV_VERSION=560.35.03 && \
curl -o .tmp/nvidia/NVIDIA-Linux-x86_64-$NV_VERSION.run \
  -fL https://download.nvidia.com/XFree86/Linux-x86_64/$NV_VERSION/NVIDIA-Linux-x86_64-$NV_VERSION.run

mc cp .tmp/nvidia/*.tar.gz aliyun/vscode/nvidia/
