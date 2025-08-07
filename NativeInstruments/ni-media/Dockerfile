FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc-9 \
    g++-9 \
    git \
    wget \
    curl \
    zip \
    unzip \
    tar \
    pkg-config \
    libboost-all-dev \
    libflac-dev \
    libvorbis-dev \
    libogg-dev \
    libgtest-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器
ENV CC=gcc-9
ENV CXX=g++-9

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 安装vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git && \
    ./vcpkg/bootstrap-vcpkg.sh

# 构建项目
RUN mkdir build && cd build && \
    cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DNIMEDIA_TREAT_WARNINGS_AS_ERRORS=OFF \
    -DCMAKE_TOOLCHAIN_FILE=/app/vcpkg/scripts/buildsystems/vcpkg.cmake \
    -DNIMEDIA_PCM_TESTS=ON \
    -DNIMEDIA_AUDIOSTREAM_TESTS=OFF \
    -DNIMEDIA_TESTS=ON && \
    cmake --build . --config Release

# 默认命令：运行PCM测试
CMD ["/app/build/pcm/test/pcm_test"]