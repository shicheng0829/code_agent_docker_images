FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖项
RUN apt-get update && apt-get install -y \
    gcc \
    make \
    libssl-dev \
    cmake \
    ninja-build \
    curl \
    git \
    vim \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 安装Rust工具链
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# 创建一个非root用户用于开发
RUN useradd -m -u 1000 user
USER user
WORKDIR /home/user/app

# 复制源代码
COPY --chown=user:user . .

# 构建项目
RUN make prepare_tests_basic ENGINE=openssl BUILD_PATH=build-openssl

# 默认命令是运行单元测试
CMD ["make", "test", "ENGINE=openssl", "BUILD_PATH=build-openssl"]