# 构建阶段
FROM ubuntu:20.04 as builder

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目和测试
RUN mkdir -p build && cd build && \
    cmake -DAMGCL_BUILD_TESTS=ON \
          -DAMGCL_BUILD_EXAMPLES=ON \
          .. && \
    make -j$(nproc)

# 运行阶段
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装运行时依赖项
RUN apt-get update && apt-get install -y \
    libboost-program-options1.71.0 \
    libboost-serialization1.71.0 \
    libboost-test1.71.0 \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 从构建阶段复制构建产物
COPY --from=builder /app/build /app/build

# 运行测试
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]