FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# 克隆并安装Abseil
RUN cd /tmp && \
    git clone --depth=1 https://github.com/abseil/abseil-cpp.git && \
    cd abseil-cpp && \
    mkdir build && cd build && \
    cmake .. -DCMAKE_CXX_STANDARD=17 && \
    make -j$(nproc) && \
    make install && \
    cd /tmp && \
    rm -rf abseil-cpp

# 安装GoogleTest
RUN apt-get update && apt-get install -y \
    libgtest-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 使用CMake构建RE2库和测试（不包括基准测试）
RUN mkdir build && cd build && \
    cmake .. -DRE2_TEST=ON && \
    make && \
    make test

# 默认命令
CMD ["/bin/bash"]