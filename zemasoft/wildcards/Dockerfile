FROM ubuntu:18.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    clang \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake . -Bbuild -DCMAKE_BUILD_TYPE=Debug -DWILDCARDS_BUILD_TESTS=ON -DWILDCARDS_BUILD_EXAMPLES=ON -DWILDCARDS_CXX_STANDARD=17 && \
    cmake --build build -- -j$(nproc)

# 默认运行测试
CMD ["/app/build/test/selftest"]