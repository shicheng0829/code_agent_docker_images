FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init

# 构建项目
RUN mkdir build && cd build && \
    cmake -DCI=ON -DCMAKE_INSTALL_PREFIX=install -DCMAKE_BUILD_TYPE=Debug .. && \
    cmake --build . -- -j$(nproc) && \
    cmake --build . --target install

# 运行单元测试
CMD ["./build/install/bin/cquery", "--ci", "--log-all-to-stderr", "--test-unit"]