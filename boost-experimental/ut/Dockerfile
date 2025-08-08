FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    clang \
    clang-format \
    clang-tidy \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DBOOST_UT_ENABLE_RUN_AFTER_BUILD=NO --log-level=DEBUG -DFETCHCONTENT_QUIET=OFF && \
    cmake --build build -j$(nproc) --verbose

# 默认运行测试
CMD ["ctest", "--test-dir", "build", "--build-config", "Debug", "-j4", "--verbose"]