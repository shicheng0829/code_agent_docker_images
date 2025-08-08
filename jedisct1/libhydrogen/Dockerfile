FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    gcc \
    make \
    cmake \
    p7zip-full \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 复制构建和测试脚本
COPY build_and_test.sh /app/build_and_test.sh
RUN chmod +x /app/build_and_test.sh

# 默认运行测试
CMD ["/app/build_and_test.sh"]