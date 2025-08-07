FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libtool \
    libcppunit-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN autoreconf -fiv
RUN ./configure
RUN make

# 运行单元测试
CMD ["make", "check"]