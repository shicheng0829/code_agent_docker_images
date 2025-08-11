FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目和测试
RUN mkdir -p build && \
    cd build && \
    cmake .. -DJSONCONS_BUILD_TESTS=On && \
    cmake --build . --config Release

# 默认命令：显示帮助信息
CMD ["sh", "-c", "echo 'jsoncons development environment ready.' && echo 'Available commands:' && echo '  - Build project: docker run --rm jsoncons-dev sh -c \"cd build && cmake --build .\"' && echo '  - Run tests: docker run --rm jsoncons-dev ./build/test/unit_tests' && echo '  - Interactive shell: docker run --rm -it jsoncons-dev bash'"]