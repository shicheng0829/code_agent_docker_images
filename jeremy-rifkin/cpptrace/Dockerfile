FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
# 包括编译器、构建工具、库依赖和Python
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    python3 \
    python3-pip \
    libunwind-dev \
    libdwarf-dev \
    zlib1g-dev \
    libzstd-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装colorama用于Python脚本（用于单元测试）
RUN pip3 install colorama

# 创建工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 构建项目（调试模式）
RUN make debug

# 默认命令：运行单元测试
CMD ["make", "test"]