FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libprotobuf-dev \
    protobuf-compiler \
    libgtest-dev \
    libssl-dev \
    libsnappy-dev \
    liblz4-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 构建项目
RUN make -j$(nproc)

# 构建测试
RUN make -C test

# 默认运行测试
CMD ["make", "-C", "test", "check"]