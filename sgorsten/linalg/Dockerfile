FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    clang \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 设置工作目录为samples目录
WORKDIR /app/samples

# 构建测试程序
RUN make

# 默认运行测试
CMD ["./linalg-test"]

# 支持的编译器变量
# 使用GCC: docker run --rm -e COMPILER=gcc linalg-test
# 使用Clang: docker run --rm -e COMPILER=clang linalg-test

# 开发模式 - 挂载本地代码并在容器中构建和测试
# docker run --rm -v $(pwd):/app linalg-test-dev make clean && make && ./linalg-test