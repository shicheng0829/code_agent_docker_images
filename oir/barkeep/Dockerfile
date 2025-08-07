FROM ubuntu:24.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    g++-13 \
    gcc-13 \
    cmake \
    git \
    python3 \
    python3-pip \
    python3-dev \
    python3-venv \
    ninja-build \
    lcov \
    wget \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置默认Python版本
RUN ln -sf /usr/bin/python3 /usr/bin/python

# 创建虚拟环境并安装Python包
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install meson pytest

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 构建C++测试
RUN CXX=g++-13 make -j$(nproc)

# 构建Python模块
RUN CXX=g++-13 meson setup build --buildtype=release --warnlevel=3
RUN meson compile -C build python

# 默认运行所有测试
CMD ["bash", "-c", "echo 'Running C++ tests...' && \
    ./test.out && \
    ./test-fmtlib.out && \
    ./test-stdfmt.out && \
    echo 'All C++ tests passed!' && \
    echo 'Running Python tests...' && \
    PYTHONPATH=build/python pytest python/tests/test.py && \
    echo 'All Python tests passed!'"]

# 提供单独运行测试的脚本
RUN echo '#!/bin/bash\necho "Running C++ tests..."\n./test.out && ./test-fmtlib.out && ./test-stdfmt.out\necho "All C++ tests passed!"' > /usr/local/bin/run-cpp-tests && \
    chmod +x /usr/local/bin/run-cpp-tests

RUN echo '#!/bin/bash\necho "Running Python tests..."\nPYTHONPATH=build/python pytest python/tests/test.py\necho "All Python tests passed!"' > /usr/local/bin/run-python-tests && \
    chmod +x /usr/local/bin/run-python-tests