FROM ubuntu:18.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装项目依赖项
# 包括编译工具、Redis服务器和客户端、以及项目所需的库
RUN apt-get update && apt-get install -y \
    cmake \
    libmsgpack-dev \
    libboost-thread-dev \
    libboost-date-time-dev \
    libboost-test-dev \
    libboost-filesystem-dev \
    libboost-system-dev \
    libboost-regex-dev \
    libhiredis-dev \
    redis-server \
    redis-tools \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . /app

# 构建项目
RUN cmake . && make

# 配置Redis以允许后台运行
RUN sed -i 's/daemonize no/daemonize yes/' /etc/redis/redis.conf

# 复制Redis Sentinel配置文件
RUN cp tests/redis-sentinel-*.conf /etc/redis/

# 修改Sentinel配置文件以允许后台运行
RUN sed -i 's/daemonize no/daemonize yes/' /etc/redis/redis-sentinel-*.conf

# 创建完整的测试脚本
RUN echo '#!/bin/bash\n\
\n\
# 启动独立的Redis实例\n\
redis-server --port 6379 --save "" &> /dev/null &\n\
\n\
# 启动高可用性实例\n\
for x in 6380 6381 6382; do\n\
  redis-server --port $x --save "" &> /dev/null &\n\
done\n\
\n\
sleep 1\n\
\n\
# 配置主从复制\n\
for x in 6381 6382; do\n\
  redis-cli -p $x slaveof 127.0.0.1 6380\n\
done\n\
\n\
sleep 1\n\
\n\
# 启动Sentinel实例\n\
for x in 26379 26380 26381; do\n\
  redis-server /etc/redis/redis-sentinel-$x.conf --sentinel --port $x &> /dev/null &\n\
done\n\
\n\
sleep 2\n\
\n\
# 运行测试\n\
REDIS_HOST=localhost ctest -V\n\
RESULT=$?\n\
\n\
# 清理所有实例\n\
jobs -p | xargs kill 2>/dev/null || true\n\
\n\
exit $RESULT\n' > /app/run-all-tests.sh && chmod +x /app/run-all-tests.sh

# 创建只运行连接测试的脚本
RUN echo '#!/bin/bash\n\
\n\
# 启动Redis实例\n\
redis-server --port 6379 --save "" &> /dev/null &\n\
\n\
sleep 1\n\
\n\
# 运行连接测试\n\
./connection_test\n\
RESULT=$?\n\
\n\
# 清理实例\n\
jobs -p | xargs kill 2>/dev/null || true\n\
\n\
exit $RESULT\n' > /app/run-connection-test.sh && chmod +x /app/run-connection-test.sh

# 提供不同的运行选项：
# 1. 默认：运行所有测试
# 2. 只运行连接测试：docker run --rm redis3m-dev ./run-connection-test.sh
# 3. 运行所有测试：docker run --rm redis3m-dev ./run-all-tests.sh
# 4. 运行自定义命令：docker run --rm -it redis3m-dev bash

CMD ["/app/run-all-tests.sh"]