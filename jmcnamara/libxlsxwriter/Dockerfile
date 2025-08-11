FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    make \
    gcc \
    clang \
    zlib1g-dev \
    libminizip-dev \
    libssl-dev \
    python3 \
    python3-pip \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 安装Python测试依赖项
RUN pip3 install pytest

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN make

# 默认命令：运行所有测试
CMD ["make", "test"]