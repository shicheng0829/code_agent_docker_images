#!/bin/bash

# 运行开发环境容器
docker run -it --rm -v "$(pwd)":/app check-dev bash