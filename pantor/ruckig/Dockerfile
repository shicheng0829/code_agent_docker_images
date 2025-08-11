FROM ubuntu:24.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_EXAMPLES=ON -DBUILD_TESTS=ON .. && \
    cmake --build . -j$(nproc)

# 默认运行测试
CMD ["sh", "-c", "cd build && ./test-target"]