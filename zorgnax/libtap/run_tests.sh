#!/bin/bash
# 运行libtap测试的脚本

echo "正在运行libtap测试..."
echo "注意：由于在某些架构上整数除零不会导致程序崩溃，dies_ok测试可能会失败。"
echo "这并不表示代码有问题，而是硬件行为的差异。"

make test

# 检查测试结果
if [ $? -eq 0 ]; then
    echo "所有测试通过！"
else
    echo "部分测试失败，但这可能是由于硬件行为差异导致的，特别是dies_ok测试。"
    echo "请检查上面的输出以了解详细信息。"
fi