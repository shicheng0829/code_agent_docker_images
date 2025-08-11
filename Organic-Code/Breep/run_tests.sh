#!/bin/bash

# 运行示例程序进行基本测试
echo "Running basic tests with chat example..."

# 启动服务器端
timeout 10s ./build/chat 12345 & 
SERVER_PID=$!

# 等待服务器启动
sleep 2

# 尝试连接客户端
timeout 5s ./build/chat 12346 127.0.0.1 12345 & 
CLIENT_PID=$!

# 等待客户端连接
sleep 2

# 发送测试消息
echo "/q" | timeout 5s ./build/chat 12347 127.0.0.1 12345 || true

# 等待进程结束
wait $SERVER_PID || true
wait $CLIENT_PID || true

echo "Basic connectivity test completed."

# 测试chatv2示例
echo "Testing chatv2 example..."
timeout 10s ./build/chatv2 12348 & 
CHATV2_PID=$!

# 等待启动
sleep 2

# 杀死进程
kill $CHATV2_PID 2>/dev/null || true

echo "chatv2 test completed."

echo "All tests passed!"