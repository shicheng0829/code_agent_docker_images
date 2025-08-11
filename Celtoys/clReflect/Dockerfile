FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libxml2-dev \
    libncurses5-dev \
    python3 \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 克隆 LLVM 和 clang 源代码（如果不存在）
RUN cd extern && \
    if [ ! -d "llvm" ]; then \
        git clone https://github.com/llvm/llvm-project.git llvm && \
        cd llvm && \
        git checkout llvmorg-12.0.0; \
    fi

# 构建 LLVM 和 clang
RUN cd extern && \
    chmod +x build-gnu.sh && \
    ./build-gnu.sh

# 创建构建目录并编译项目
RUN mkdir -p cmake-build && cd cmake-build && \
    cmake -G "Unix Makefiles" .. && \
    make -j$(nproc)

# 运行测试
CMD ["sh", "-c", "cd cmake-build && make && cd ../src/clReflectTest && ./clReflectTest"]