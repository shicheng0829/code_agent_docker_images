FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    libnghttp2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 配置和构建库及所有组件
RUN ./configure --with-openssl --with-nghttp2 --with-kcp --with-mqtt && \
    make libhv evpp unittest

# 默认命令是运行单元测试
CMD ["make", "run-unittest"]