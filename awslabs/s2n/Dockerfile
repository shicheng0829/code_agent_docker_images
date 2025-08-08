FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    git \
    python3 \
    python3-pip \
    ninja-build \
    gdb \
    valgrind \
    clang \
    clang-tools \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake . -Bbuild \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=on \
    && cmake --build build -j $(nproc)

# 默认运行单元测试
CMD ["ctest", "--test-dir", "build", "--output-on-failure"]