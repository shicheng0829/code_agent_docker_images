FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项和开发工具
RUN apt-get update && apt-get install -y --no-install-suggests --no-install-recommends \
    g++ \
    cmake \
    gcovr \
    libgflags-dev \
    libgmock-dev \
    libgtest-dev \
    libunwind-dev \
    ninja-build \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build

# 复制并设置测试脚本权限
COPY run_tests.sh /app/
RUN chmod +x /app/run_tests.sh

# 设置默认命令为bash，方便开发时进入容器
CMD ["/bin/bash"]