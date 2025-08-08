#!/bin/bash
# 运行测试的脚本

# 检查是否提供了测试命令
if [ $# -eq 0 ]; then
  echo "运行所有测试..."
  lein test
else
  echo "运行指定的命令: $*"
  exec "$@"
fi