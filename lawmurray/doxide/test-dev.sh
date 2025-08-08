#!/bin/bash

# Doxide开发环境测试脚本

set -e  # 遇到错误时退出

echo "🔬 Doxide开发环境测试"

# 在项目目录中运行测试
cd /workspace

echo "📝 构建文档"
doxide build

# 检查是否生成了关键文件
echo "🔍 检查生成的文件"
if [ -f "docs/demo/index.md" ]; then
    echo "✅ 成功生成 docs/demo/index.md"
else
    echo "❌ 未生成 docs/demo/index.md"
    echo "docs目录内容:"
    ls -la docs/
    echo "docs/demo目录内容:"
    ls -la docs/demo/ 2>/dev/null || echo "docs/demo目录不存在"
    exit 1
fi

# 检查parsing目录是否存在
if [ -d "docs/demo/parsing" ]; then
    echo "✅ 成功生成 docs/demo/parsing 目录"
else
    echo "❌ 未生成 docs/demo/parsing 目录"
    echo "docs/demo目录内容:"
    ls -la docs/demo/
    exit 1
fi

echo "🌐 构建网站"
mkdocs build

if [ -f "site/index.html" ]; then
    echo "✅ 成功生成网站文件 site/index.html"
else
    echo "❌ 未生成网站文件 site/index.html"
    echo "site目录内容:"
    ls -la site/ 2>/dev/null || echo "site目录不存在"
    exit 1
fi

echo "📊 测试代码覆盖率功能"
doxide cover > coverage.json

if [ -f "coverage.json" ]; then
    echo "✅ 成功生成覆盖率报告 coverage.json"
    # 检查文件是否包含有效的JSON
    if jq empty coverage.json 2>/dev/null; then
        echo "✅ 覆盖率报告是有效的JSON格式"
    else
        echo "⚠️ 覆盖率报告不是有效的JSON格式"
    fi
else
    echo "❌ 未生成覆盖率报告 coverage.json"
fi

echo "🧹 清理输出"
doxide clean

# 检查清理是否成功
if [ ! -f "docs/demo/index.md" ] || [ ! -d "docs/demo/parsing" ]; then
    echo "✅ 清理成功"
else
    echo "❌ 清理失败"
fi

echo "🎉 所有测试完成！"