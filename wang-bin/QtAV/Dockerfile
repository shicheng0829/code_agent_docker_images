FROM ubuntu:18.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更新包列表并安装基础依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    wget \
    ca-certificates \
    qt5-default \
    qtbase5-dev \
    libqt5opengl5-dev \
    && rm -rf /var/lib/apt/lists/*

# 再次更新并安装更多依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libavutil-dev \
    libavfilter-dev \
    libswresample-dev \
    libass-dev \
    libva-dev \
    libxv-dev \
    portaudio19-dev \
    libpulse-dev \
    libopenal-dev \
    qttools5-dev-tools \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . /app

# 构建项目
RUN mkdir build && \
    cd build && \
    cmake .. -DBUILD_TESTS=ON -DBUILD_EXAMPLES=OFF -DBUILD_PLAYERS=OFF && \
    make -j$(nproc)

# 运行测试
CMD ["bash", "-c", "cd build && ctest --output-on-failure || true"]