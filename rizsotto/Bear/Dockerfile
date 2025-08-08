FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    protobuf-compiler-grpc \
    libgrpc++-dev \
    libssl-dev \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装Python依赖
RUN pip3 install lit pycodestyle

# 创建工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN cmake -B build -S . -DENABLE_UNIT_TESTS=ON -DENABLE_FUNC_TESTS=ON \
    && cmake --build build --parallel 4

# 运行测试
CMD ["cmake", "--build", "build", "--target", "test"]