FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 编译测试
RUN cd build && \
    cmake -DENTT_BUILD_TESTING=ON -DENTT_BUILD_LIB=ON -DENTT_BUILD_EXAMPLE=ON .. && \
    make -j4

# 默认命令：运行测试
CMD ["sh", "-c", "cd build && ctest -C Debug -j4 --output-on-failure"]

# 开发命令示例：
# 构建镜像: docker build -t entt-dev .
# 运行测试: docker run --rm entt-dev
# 交互式开发: docker run -it --rm -v $(pwd):/app entt-dev bash
# 单独构建: docker run -it --rm -v $(pwd):/app entt-dev bash -c "cd build && make -j4"