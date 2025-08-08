FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    python3 \
    python3-pip \
    python3-venv \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 创建虚拟环境并安装Python依赖
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --upgrade pip setuptools wheel
RUN pip install absl-py

# 构建C++库和测试
RUN mkdir build && \
    cd build && \
    cmake -G "Ninja" \
          -DBENCHMARK_DOWNLOAD_DEPENDENCIES=ON \
          -DCMAKE_BUILD_TYPE=Release \
          -DBENCHMARK_ENABLE_GTEST_TESTS=ON \
          .. && \
    cmake --build . --config Release

# 运行C++测试
CMD ["sh", "-c", "cd build && ctest -C Release -VV"]