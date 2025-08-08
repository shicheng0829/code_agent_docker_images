FROM ubuntu:24.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc-13 \
    g++-13 \
    git \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器
ENV CC=gcc-13
ENV CXX=g++-13

# 设置工作目录
WORKDIR /app

# 复制源代码和脚本
COPY . .

# 使脚本可执行
RUN chmod +x run_tests.sh && chmod +x dev.sh

# 构建项目
RUN CXXFLAGS="-g3" cmake -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_STANDARD=23 && \
    cmake --build build -j$(nproc)

# 默认运行核心测试
CMD ["./run_tests.sh"]