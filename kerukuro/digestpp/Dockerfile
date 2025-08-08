FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建并安装库
RUN mkdir build && cd build && \
    cmake .. && \
    make && \
    make install && \
    # 清理构建文件以减小镜像大小
    cd / && rm -rf /app/build

# 构建测试
RUN cd test && \
    mkdir build && cd build && \
    cmake .. && \
    make

# 运行自测
CMD ["./test/build/test"]