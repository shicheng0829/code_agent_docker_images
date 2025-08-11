FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 构建项目和测试
WORKDIR /app/build
RUN cmake -DCMAKE_BUILD_TYPE=Release \
          -DQUILL_BUILD_TESTS=ON \
          -DQUILL_BUILD_EXAMPLES=ON \
          -DQUILL_VERBOSE_MAKEFILE=ON \
          ..
RUN cmake --build . --parallel $(nproc)

# 运行测试
CMD ["ctest", "--output-on-failure", "--parallel", "4"]