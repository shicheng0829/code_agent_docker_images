FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    clang-11 \
    cmake \
    ninja-build \
    git \
    libtinfo-dev \
    libclang-11-dev \
    libncurses5 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 克隆项目及其子模块
RUN git clone --recurse-submodules https://github.com/jsoysouvanh/Refureku.git .

# 创建符号链接以解决libtinfo版本问题
RUN ln -s /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libtinfo.so.5 || true

# 构建项目
RUN cmake -B Build -DCMAKE_BUILD_TYPE=Debug -DRFK_DEV=1 -G "Ninja" && \
    cmake --build Build --config Debug --verbose

# 运行测试
CMD ["sh", "-c", "cd Build && ctest -C Debug -V"]