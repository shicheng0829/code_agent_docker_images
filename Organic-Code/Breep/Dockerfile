FROM ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 复制测试脚本并设置权限
COPY run_tests.sh .
RUN chmod +x run_tests.sh

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make

# 默认命令：运行测试
CMD ["./run_tests.sh"]