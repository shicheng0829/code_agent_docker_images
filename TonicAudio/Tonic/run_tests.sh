#!/bin/bash

echo "Running Tonic unit tests..."

# 编译测试程序
cd /app/examples/Standalone/Linux
make clean
make AUDIO_API=LINUX_PULSE

# 运行性能测试（这是项目中唯一的测试）
echo "Starting performance tests..."
./demo

echo "Tests completed."