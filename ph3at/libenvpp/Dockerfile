FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 初始化子模块
RUN git submodule update --init

# 创建构建目录并编译项目和测试
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DLIBENVPP_TESTS=ON && \
    cmake --build . --config Debug

# 运行测试作为构建的一部分
RUN cd build && ctest -C Debug --output-on-failure

# 默认命令是交互式shell
CMD ["/bin/bash"]