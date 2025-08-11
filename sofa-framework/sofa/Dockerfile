FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libboost-all-dev \
    libeigen3-dev \
    libglew-dev \
    libgtest-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libqglviewer-dev-qt5 \
    libmetis-dev \
    libtinyxml2-dev \
    zlib1g-dev \
    libgl1-mesa-dev \
    libglx-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxrandr-dev \
    wget \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装CMake 3.22或更高版本
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y cmake

# 创建工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 创建构建目录
RUN mkdir build

# 进入构建目录并配置项目（启用测试）
WORKDIR /app/build

# 使用标准配置并启用测试
RUN cmake .. -DCMAKE_BUILD_TYPE=Release \
    -DSOFA_BUILD_TESTS=ON \
    -DSOFA_BUILD_SIMPLEAPI_EXAMPLES=ON \
    -DPLUGIN_SOFAGLFW=ON \
    -DSOFA_FETCH_SOFAGLFW=ON \
    -DPLUGIN_SOFAIMGUI=ON

# 构建项目
RUN make -j$(nproc)

# 运行测试
CMD ["make", "test"]