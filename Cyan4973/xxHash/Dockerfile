FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和测试所需的依赖项
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    gcc-multilib \
    valgrind \
    cppcheck \
    clang \
    clang-tools \
    cmake \
    git \
    time \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令是运行所有测试
CMD ["make", "test-all"]