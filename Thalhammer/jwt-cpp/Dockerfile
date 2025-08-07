# 多阶段构建：构建阶段
FROM ubuntu:20.04 AS builder

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    libgtest-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 构建并安装Google Test
WORKDIR /tmp/gtest
RUN cmake /usr/src/googletest && \
    make && \
    make install

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake .. -DJWT_BUILD_TESTS=ON -DJWT_BUILD_EXAMPLES=ON && \
    make

# 运行阶段
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装运行时依赖项
RUN apt-get update && apt-get install -y \
    libssl1.1 \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 从构建阶段复制已编译的文件
# 使用--chown选项确保文件所有权正确
COPY --chown=1000:1000 --from=builder /app/build /app/build

# 创建非root用户并切换到该用户
RUN useradd -m -u 1000 user
USER user

# 默认命令：运行测试
CMD ["bash", "-c", "cd build && ctest --output-on-failure"]