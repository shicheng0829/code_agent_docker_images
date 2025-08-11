FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    libssl-dev \
    doxygen \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 默认命令是运行测试
CMD ["sh", "-c", "mkdir -p build && cd build && cmake .. -DMAILIO_BUILD_TESTS=ON -DMAILIO_BUILD_EXAMPLES=OFF -DMAILIO_BUILD_DOCUMENTATION=OFF && make -j$(nproc) && ctest --output-on-failure"]