#!/bin/bash

# 运行交互式开发环境
docker run -it --rm \
  -v $(pwd):/app \
  -w /app \
  cppitertools-dev-env \
  bash