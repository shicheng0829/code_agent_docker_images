FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件（包括.git目录以支持子模块）
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 构建项目
RUN mkdir -p build && \
    cd build && \
    cmake .. && \
    make -j$(nproc)

# 默认命令是运行测试
CMD ["sh", "-c", "cd build/bin && ./config_loader_test"]