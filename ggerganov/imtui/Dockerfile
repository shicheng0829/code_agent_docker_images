FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libncurses5-dev \
    libcurl4-openssl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make

# 测试构建的二进制文件是否存在且可执行
RUN cd build && \
    test -x bin/imtui-example-ncurses0 && \
    test -x bin/slack && \
    test -x bin/hnterm && \
    echo "All binaries are present and executable"

# 默认命令运行示例程序
CMD ["./build/bin/imtui-example-ncurses0"]