FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/cppcodec

# 复制源代码到容器中
COPY . .

# 初始化并更新子模块
RUN git submodule sync --recursive && git submodule update --init --recursive

# 创建构建目录并进入
RUN mkdir build && cd build

# 默认命令：构建项目并运行测试
CMD ["/bin/bash", "-c", "cd build && cmake .. -DCPPCODEC_BUILD_TESTING=ON -DCPPCODEC_BUILD_EXAMPLES=ON && make -j$(nproc) && CTEST_OUTPUT_ON_FAILURE=1 make test"]