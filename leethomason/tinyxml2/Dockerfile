FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    tree \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建并构建所有配置
RUN cmake -G Ninja -S . -B build-static-dbg -DCMAKE_BUILD_TYPE=Debug "-DCMAKE_DEBUG_POSTFIX=d_static" && \
    cmake --build build-static-dbg && \
    cmake -G Ninja -S . -B build-shared-dbg -DCMAKE_BUILD_TYPE=Debug -DCMAKE_DEBUG_POSTFIX=d -DBUILD_SHARED_LIBS=ON && \
    cmake --build build-shared-dbg && \
    cmake -G Ninja -S . -B build-static-rel -DCMAKE_BUILD_TYPE=Release "-DCMAKE_RELEASE_POSTFIX=_static" && \
    cmake --build build-static-rel && \
    cmake -G Ninja -S . -B build-shared-rel -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON && \
    cmake --build build-shared-rel

# 复制测试运行脚本
COPY test-runner.sh /usr/local/bin/test-runner.sh
RUN chmod +x /usr/local/bin/test-runner.sh

# 提供不同的运行选项
CMD ["test-runner.sh"]

# 默认进入静态调试版本的构建目录
WORKDIR /app/build-static-dbg