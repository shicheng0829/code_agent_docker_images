#!/bin/bash

# 调试脚本

echo "当前目录:"
pwd

echo "目录内容:"
ls -la

echo "创建测试目录并进入"
mkdir -p /tmp/doxide-debug
cd /tmp/doxide-debug

echo "初始化doxide"
printf "n\nn\nn\nn\nn\nn\n" | doxide init || true

echo "目录内容 after init:"
ls -la

echo "构建文档"
doxide build

echo "docs 目录内容:"
ls -la docs/

echo "docs/demo 目录内容:"
ls -la docs/demo/