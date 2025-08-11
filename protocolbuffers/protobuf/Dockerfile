FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    wget \
    unzip \
    pkg-config \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# 从GitHub直接安装Bazel
RUN mkdir -p /usr/local/bazel && \
    cd /tmp && \
    wget https://github.com/bazelbuild/bazel/releases/download/7.6.1/bazel-7.6.1-linux-x86_64 && \
    chmod +x bazel-7.6.1-linux-x86_64 && \
    mv bazel-7.6.1-linux-x86_64 /usr/local/bin/bazel && \
    bazel --version

# 安装Python和pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# 升级pip
RUN python3 -m pip install --upgrade pip

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 构建项目（使用CMake）
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_CXX_STANDARD=17 && \
    cmake --build . --parallel 10

# 运行测试
CMD ["sh", "-c", "cd build && ctest --verbose"]