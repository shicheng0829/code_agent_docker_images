FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libv8-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译项目（构建库和测试）
RUN mkdir build && cd build && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON .. && \
    cmake --build . --config Release

# 运行测试
CMD ["sh", "-c", "cd build && ctest -C Release -V"]