FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    qtbase5-dev \
    git \
    vim \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DSIGSLOT_COMPILE_TESTS=ON -DSIGSLOT_COMPILE_EXAMPLES=ON && \
    cmake --build . --target sigslot-tests

# 设置工作目录为构建目录
WORKDIR /app/build

# 默认运行测试
CMD ["ctest", "--output-on-failure"]