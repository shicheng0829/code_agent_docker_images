FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    swig \
    freeglut3-dev \
    zlib1g-dev \
    libgtest-dev \
    python3 \
    python3-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# 安装Python依赖
RUN pip3 install setuptools wheel pytest

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目
RUN cmake -G "Unix Makefiles" -DPARTIO_GTEST_ENABLED=ON -DCMAKE_BUILD_TYPE=Debug . && \
    cmake --build . --target all && \
    ldconfig

# 设置库路径
ENV LD_LIBRARY_PATH=/app/src/lib

# 默认命令：运行测试
CMD ["ctest", "--output-on-failure"]