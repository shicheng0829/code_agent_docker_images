FROM gcc:latest

# 设置工作目录
WORKDIR /app

# 安装依赖
RUN apt-get update && apt-get install -y \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 复制脚本目录以获取依赖安装脚本
COPY script/ ./script/

# 安装doctest依赖
RUN script/ci_install_deps.sh

# 复制其余源代码
COPY . .

# 默认命令：构建并运行测试
CMD ["sh", "-c", "cmake -S test -B build -D CMAKE_BUILD_TYPE=Debug && cmake --build build -j $(nproc) && ctest --test-dir build --output-on-failure"]