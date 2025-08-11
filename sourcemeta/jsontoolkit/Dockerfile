FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    pkg-config \
    libboost-all-dev \
    liburiparser-dev \
    zlib1g-dev \
    libssl-dev \
    libyaml-cpp-dev \
    doxygen \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目（启用测试）
RUN cmake -S . -B ./build \
    -DCMAKE_BUILD_TYPE=Release \
    -DSOURCEMETA_CORE_TESTS=ON \
    -DSOURCEMETA_CORE_BENCHMARK=OFF \
    -DSOURCEMETA_CORE_DOCS=OFF \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_COMPILE_WARNING_AS_ERROR=OFF

RUN cmake --build ./build --config Release --parallel $(nproc)

# 默认命令：运行测试
CMD ["sh", "-c", "cd ./build && ctest --build-config Release --output-on-failure --parallel $(nproc)"]

# 开发命令：进入bash shell
# 使用 docker run -it jsontoolkit-dev bash 来进入交互式开发环境