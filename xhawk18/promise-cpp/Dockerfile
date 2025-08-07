FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装基本依赖项
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    libboost-all-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make

# 默认命令：运行单元测试
CMD ["bash", "-c", "cd build && echo 'Running tests...' && ./test0 && ./chain_defer_test && ./simple_timer && echo 'All tests passed!'"]