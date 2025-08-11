FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    g++-12 \
    clang-15 \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器为g++-12
ENV CC=/usr/bin/gcc-12
ENV CXX=/usr/bin/g++-12

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目（启用测试）
RUN cmake -D ADA_TESTING=ON -D ADA_BENCHMARKS=ON -D CMAKE_CXX_COMPILER=/usr/bin/g++-12 -G Ninja -B build && \
    cmake --build build -j=4

# 运行测试
CMD ["ctest", "--output-on-failure", "--test-dir", "build"]