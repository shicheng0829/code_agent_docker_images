FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libglu1-mesa-dev \
    libxi-dev \
    libxmu-dev \
    mesa-common-dev \
    wget \
    zip \
    python3 \
    lcov \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制整个项目到容器中
COPY . .

# 构建Liquidfun及其依赖项
RUN cd liquidfun/Box2D && \
    mkdir -p build && \
    cd build && \
    cmake .. -DBOX2D_BUILD_UNITTESTS=ON -DBOX2D_BUILD_EXAMPLES=OFF -DPYTHON_EXECUTABLE=/usr/bin/python3 -DCMAKE_CXX_FLAGS="-Wno-error=class-memaccess" && \
    make -j$(nproc)

# 复制测试脚本到构建目录
RUN cp liquidfun/Box2D/Unittests/run_tests.sh liquidfun/Box2D/build/Unittests/

# 运行单元测试
WORKDIR /app/liquidfun/Box2D/build/Unittests
RUN chmod +x run_tests.sh
CMD ["./run_tests.sh", "-n", "-C"]