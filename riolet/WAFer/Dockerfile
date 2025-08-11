FROM ubuntu:20.04

# 避免交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gcc \
    clang \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN make clean && make

# 运行构建测试
RUN if [ -f "example" ]; then echo "Build test passed: example built successfully"; else echo "Build test failed: example not built"; exit 1; fi

# 默认命令
CMD ["./example"]