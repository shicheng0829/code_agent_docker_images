FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    libz-dev \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/libwebsockets

# 复制源代码到容器中
COPY . .

# 创建构建目录并进入
RUN mkdir build && cd build

# 设置默认构建类型
ENV BUILD_TYPE=Debug

# 构建项目
RUN cd build && cmake .. -DCMAKE_BUILD_TYPE=$BUILD_TYPE && make

# 默认命令：显示帮助信息
CMD ["echo", "Libwebsockets development environment ready. Run tests with: docker run --rm libwebsockets-dev sh -c 'cd build && ctest --output-on-failure'"]