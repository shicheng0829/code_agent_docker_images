FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    valgrind \
    binutils-dev \
    libdwarf-dev \
    libdw-dev \
    libelf-dev \
    python3-pip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 安装conan
RUN pip3 install conan

# 创建非root用户
RUN useradd -m -u 1000 user
USER user
WORKDIR /home/user/app

# 复制源代码到容器中
COPY --chown=user:user . .

# 创建构建目录并编译
RUN mkdir build && cd build && \
    cmake .. -DBACKWARD_TESTS=ON && \
    cmake --build .

# 运行测试
CMD ["sh", "-c", "cd build && ctest --verbose"]