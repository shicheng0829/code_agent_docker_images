FROM ubuntu:24.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
# 使用与CI配置相同的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgmock-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目和测试
# 使用与CI配置相同的CMake选项
RUN cmake -S . -B build -DBITSERY_BUILD_TESTS=ON -DBITSERY_BUILD_EXAMPLES=ON && \
    cmake --build build

# 默认运行测试
CMD ["ctest", "--test-dir", "build"]