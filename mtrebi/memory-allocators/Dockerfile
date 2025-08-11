FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make

# 默认命令：运行基准测试
CMD ["./build/main"]

# 开发用途的替代命令：
# 1. 构建但不运行：docker run --rm memory-allocators echo "Build completed"
# 2. 进入交互式shell：docker run -it --rm memory-allocators bash