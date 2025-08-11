FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    gdb \
    valgrind \
    clang-format \
    vim \
    nano \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 复制入口脚本
COPY docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

# 创建构建目录并构建项目
RUN mkdir -p vsbuild && cd vsbuild && cmake .. && cmake --build . --config Release

# 默认命令是运行测试
CMD ["test"]

# 为开发提供不同的入口点
# 构建项目: docker run --rm -v $(pwd):/app bitmapplusplus-dev build
# 运行测试: docker run --rm -v $(pwd):/app bitmapplusplus-dev test
# 格式化代码: docker run --rm -v $(pwd):/app bitmapplusplus-dev format
# 清理构建: docker run --rm -v $(pwd):/app bitmapplusplus-dev clean
# 交互式shell: docker run -it -v $(pwd):/app bitmapplusplus-dev bash

ENTRYPOINT ["/app/docker-entrypoint.sh"]