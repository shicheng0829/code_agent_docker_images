FROM ubuntu:18.04

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc \
    g++ \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/raknet

# 复制源代码到容器中
COPY . .

# 构建RakNet库和测试程序
RUN mkdir build && cd build && \
    cmake .. -DRAKNET_ENABLE_SAMPLES=ON -DRAKNET_SAMPLE_Tests=ON && \
    make -j$(nproc)

# 运行测试
CMD ["./build/Samples/Tests/Tests"]