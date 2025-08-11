FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项，包括更高版本的CMake
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 下载并安装CMake 3.22或更高版本
RUN wget https://github.com/Kitware/CMake/releases/download/v3.22.0/cmake-3.22.0-linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.22.0-linux-x86_64.tar.gz && \
    mv cmake-3.22.0-linux-x86_64 /opt/cmake && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

# 验证CMake版本
RUN cmake --version

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake -DBOX2D_SAMPLES=OFF -DBOX2D_UNIT_TESTS=ON -DBUILD_SHARED_LIBS=OFF .. && \
    cmake --build . --config Debug

# 运行单元测试
CMD ["sh", "-c", "cd build && ./bin/test"]