#!/bin/bash

# 运行单元测试的脚本

# 创建测试目录
mkdir -p /tmp/doxide-test
cd /tmp/doxide-test

# 初始化doxide配置
doxide init << EOF
y
y
y
y
y
y
EOF

# 构建文档
doxide build

# 检查是否生成了文档文件
if [ -f "docs/index.md" ]; then
    echo "✅ 单元测试通过：成功生成文档文件"
else
    echo "❌ 单元测试失败：未生成文档文件"
    exit 1
fi

# 使用mkdocs构建网站
mkdocs build

# 检查是否生成了网站文件
if [ -f "site/index.html" ]; then
    echo "✅ 单元测试通过：成功生成网站文件"
else
    echo "❌ 单元测试失败：未生成网站文件"
    exit 1
fi

echo "🎉 所有单元测试通过！"