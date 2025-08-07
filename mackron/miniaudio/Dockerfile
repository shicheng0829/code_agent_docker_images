FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libflac-dev \
    libvorbis-dev \
    libopus-dev \
    libasound2-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建测试
RUN mkdir -p build && cd build && \
    cmake -DMINIAUDIO_BUILD_TESTS=ON .. && \
    make -j$(nproc)

# 创建运行所有测试的脚本
RUN echo '#!/bin/bash' > /app/run-tests.sh && \
    echo 'echo "Running conversion tests..."' >> /app/run-tests.sh && \
    echo './build/miniaudio_conversion' >> /app/run-tests.sh && \
    echo 'echo "Running filtering tests..."' >> /app/run-tests.sh && \
    echo './build/miniaudio_filtering /app/data/16-44100-stereo.flac' >> /app/run-tests.sh && \
    echo 'echo "Running generation tests..."' >> /app/run-tests.sh && \
    echo './build/miniaudio_generation' >> /app/run-tests.sh && \
    echo 'echo "All tests completed!"' >> /app/run-tests.sh && \
    chmod +x /app/run-tests.sh

# 创建运行单个测试的脚本
RUN echo '#!/bin/bash' > /app/run-single-test.sh && \
    echo 'if [ "$#" -ne 1 ]; then' >> /app/run-single-test.sh && \
    echo '  echo "Usage: $0 <test_name>"' >> /app/run-single-test.sh && \
    echo '  echo "Available tests: conversion, filtering, generation, cpp, deviceio"' >> /app/run-single-test.sh && \
    echo '  exit 1' >> /app/run-single-test.sh && \
    echo 'fi' >> /app/run-single-test.sh && \
    echo '' >> /app/run-single-test.sh && \
    echo 'case $1 in' >> /app/run-single-test.sh && \
    echo '  conversion)' >> /app/run-single-test.sh && \
    echo '    ./build/miniaudio_conversion' >> /app/run-single-test.sh && \
    echo '    ;;' >> /app/run-single-test.sh && \
    echo '  filtering)' >> /app/run-single-test.sh && \
    echo '    ./build/miniaudio_filtering /app/data/16-44100-stereo.flac' >> /app/run-single-test.sh && \
    echo '    ;;' >> /app/run-single-test.sh && \
    echo '  generation)' >> /app/run-single-test.sh && \
    echo '    ./build/miniaudio_generation' >> /app/run-single-test.sh && \
    echo '    ;;' >> /app/run-single-test.sh && \
    echo '  cpp)' >> /app/run-single-test.sh && \
    echo '    ./build/miniaudio_cpp --auto' >> /app/run-single-test.sh && \
    echo '    ;;' >> /app/run-single-test.sh && \
    echo '  deviceio)' >> /app/run-single-test.sh && \
    echo '    ./build/miniaudio_deviceio --auto' >> /app/run-single-test.sh && \
    echo '    ;;' >> /app/run-single-test.sh && \
    echo '  *)' >> /app/run-single-test.sh && \
    echo '    echo "Unknown test: $1"' >> /app/run-single-test.sh && \
    echo '    echo "Available tests: conversion, filtering, generation, cpp, deviceio"' >> /app/run-single-test.sh && \
    echo '    exit 1' >> /app/run-single-test.sh && \
    echo '    ;;' >> /app/run-single-test.sh && \
    echo 'esac' >> /app/run-single-test.sh && \
    chmod +x /app/run-single-test.sh

# 默认命令：运行所有测试
CMD ["/app/run-tests.sh"]