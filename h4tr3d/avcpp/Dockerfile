FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    ninja-build \
    python3 \
    python3-pip \
    libavcodec-dev \
    libavdevice-dev \
    libavfilter-dev \
    libavformat-dev \
    libavutil-dev \
    libpostproc-dev \
    libswscale-dev \
    libswresample-dev \
    wget \
    git \
    pkg-config \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装较新版本的CMake和Meson
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y cmake && \
    pip3 install meson

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 更新子模块
RUN git submodule update --init --recursive

# 构建项目并运行测试的脚本
RUN echo '#!/bin/bash\necho "Building with CMake..."\nmkdir -p build-cmake\ncd build-cmake\ncmake ..\nmake -j$(nproc)\necho "Running CMake tests..."\nctest --output-on-failure\ncd ..\necho "Building with Meson..."\nmkdir -p build-meson\ncd build-meson\nmeson ..\nninja\necho "Running Meson tests..."\nmeson test\ncd ..\necho "All builds and tests completed successfully!"\n' > /app/run-tests.sh

RUN chmod +x /app/run-tests.sh

# 默认命令：运行测试
CMD ["/app/run-tests.sh"]