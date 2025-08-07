FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_CXX_STANDARD=20 -DCMAKE_CXX_STANDARD_REQUIRED=ON && \
    make -j$(nproc) TermOx.tests.unit

# 运行单元测试
CMD ["sh", "-c", "cd build && ./tests/TermOx.tests.unit"]