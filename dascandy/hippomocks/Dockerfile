FROM --platform=linux/amd64 ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 使用CMake生成Makefile并构建项目
RUN cmake . && make

# 运行测试
CMD ["make", "test"]