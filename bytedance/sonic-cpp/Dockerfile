FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    git \
    gcc \
    g++ \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 安装Bazel
RUN wget https://github.com/bazelbuild/bazel/releases/download/4.0.0/bazel-4.0.0-installer-linux-x86_64.sh && \
    chmod +x bazel-4.0.0-installer-linux-x86_64.sh && \
    ./bazel-4.0.0-installer-linux-x86_64.sh && \
    rm bazel-4.0.0-installer-linux-x86_64.sh

# 设置工作目录
WORKDIR /sonic-cpp

# 复制源代码
COPY . .

# 确保我们的脚本具有执行权限
RUN chmod +x scripts/run_cmake_arm64.sh

# 默认命令：运行单元测试
CMD ["bash", "./scripts/run_cmake_arm64.sh"]