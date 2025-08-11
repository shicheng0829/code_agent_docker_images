FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update --fix-missing -y && \
    apt-get install -y \
    build-essential \
    cppcheck \
    clang \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 配置项目
RUN ./configure --enable-debug --enable-maintainer --with-sanitizer

# 构建项目
RUN make

# 默认命令
CMD ["/bin/bash"]