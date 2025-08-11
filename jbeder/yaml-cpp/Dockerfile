FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgtest-dev \
    libgmock-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/yaml-cpp

# 复制源代码到容器中
COPY . .

# 创建构建目录并进入
RUN mkdir build && cd build

# 配置CMake以构建测试
RUN cd build && cmake .. -DYAML_CPP_BUILD_TESTS=ON -DCMAKE_BUILD_TYPE=Debug

# 构建项目
RUN cd build && make -j$(nproc)

# 默认命令：运行测试
CMD ["bash", "-c", "cd build && ctest --output-on-failure"]