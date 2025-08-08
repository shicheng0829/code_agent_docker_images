FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgtest-dev \
    googletest \
    && rm -rf /var/lib/apt/lists/*

# 将源代码复制到容器中
COPY . /usr/src/reaction
WORKDIR /usr/src/reaction

# 构建项目和测试
RUN cmake -S . -DBUILD_TESTS=TRUE -B build && \
    cmake --build build/

# 运行测试
CMD ["ctest", "--test-dir", "build"]