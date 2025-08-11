FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    cmake \
    g++-11 \
    clang-12 \
    libclang-15-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器为GCC 11
ENV CC=gcc-11
ENV CXX=g++-11

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake -DCMAKE_BUILD_TYPE=Debug . && \
    cmake --build . --config Debug

# 默认命令运行测试
CMD ["ctest"]

# 提供一个交互式的bash shell用于开发
# 使用方式: docker run -it --rm protopuf-dev bash