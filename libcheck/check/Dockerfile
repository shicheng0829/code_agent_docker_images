FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装项目依赖和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    automake \
    autoconf \
    libtool \
    pkg-config \
    texinfo \
    texi2html \
    doxygen \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN autoreconf -i && \
    ./configure && \
    make

# 默认运行单元测试
CMD ["make", "check"]