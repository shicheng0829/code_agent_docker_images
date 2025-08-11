FROM ubuntu:18.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    scons \
    libboost-all-dev \
    libssl-dev \
    git \
    vim \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/websocketpp

# 复制源代码到容器中
COPY . .

# 默认命令：构建并运行测试
CMD ["bash", "-c", "mkdir -p build && cd build && cmake -DBUILD_TESTS=ON .. && cmake --build . && ctest --output-on-failure"]

# 也可以用于交互式开发会话
# 使用 `docker run -it websocketpp-test bash` 进入交互模式
