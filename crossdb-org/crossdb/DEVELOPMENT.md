#!/bin/bash
# 开发环境使用说明

echo "CrossDB 开发环境"
echo "=================="
echo
echo "构建项目:"
echo "  make build"
echo
echo "运行CLI工具:"
echo "  ./build/xdb-cli"
echo
echo "运行测试 (在容器内):"
echo "  方法1 - 使用已安装的库:"
echo "    make -C test/"
echo
echo "  方法2 - 直接从源码编译测试:"
echo "    cd test && gcc -o xdb_smoke_test.bin xdb_smoke_test.c ../src/crossdb.c -I../include -lpthread -g && ./xdb_smoke_test.bin"
echo
echo "清理构建结果:"
echo "  make clean"
echo
echo "更多信息请查看 README.md"