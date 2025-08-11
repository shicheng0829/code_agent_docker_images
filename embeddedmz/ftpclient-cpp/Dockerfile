FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libcurl4-openssl-dev \
    libgtest-dev \
    ninja-build \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DSKIP_TESTS_BUILD=OFF -DTEST_INI_FILE="/app/TestFTP/template_test_conf.ini" && \
    make

# 设置默认命令为bash shell
CMD ["/bin/bash"]