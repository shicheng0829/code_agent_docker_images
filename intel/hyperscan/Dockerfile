FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ragel \
    libboost-dev \
    libpcre3-dev \
    python3 \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

# 运行单元测试
CMD ["sh", "-c", "cd build && make unit"]