FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    python3 \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目，修复警告选项兼容性问题并构建测试程序
RUN sed -i 's/-Wno-unsafe-buffer-usage//g' build/ninja/clang.py && \
    sed -i 's/-Wno-pre-c11-compat//g' build/ninja/clang.py && \
    python3 configure.py --target linux && \
    ninja

# 默认运行测试
CMD ["./bin/linux/release/aarch64/rpmalloc-test"]