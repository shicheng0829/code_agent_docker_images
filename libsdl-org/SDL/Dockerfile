FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    pkg-config \
    libasound2-dev \
    libpulse-dev \
    libaudio-dev \
    libjack-dev \
    libsdl2-dev \
    libx11-dev \
    libxext-dev \
    libxrandr-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxi-dev \
    libxss-dev \
    libxkbcommon-dev \
    libwayland-dev \
    libxkbcommon-dev \
    libegl1-mesa-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgles2-mesa-dev \
    libdbus-1-dev \
    libibus-1.0-dev \
    libudev-dev \
    fcitx-libs-dev \
    libpipewire-0.3-dev \
    libdecor-0-dev \
    libsndio-dev \
    git \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir build

# 构建SDL库和测试程序
WORKDIR /usr/src/app/build
RUN cmake .. -DSDL_TESTS=ON -DSDL_EXAMPLES=ON -DCMAKE_BUILD_TYPE=Debug
RUN cmake --build . --parallel $(nproc)

# 运行单元测试
CMD ["ctest", "-V"]