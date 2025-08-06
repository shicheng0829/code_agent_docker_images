FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libasound2-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libboost-dev \
    libcurl4-openssl-dev \
    libgtk-3-dev \
    libgif-dev \
    libglu1-mesa-dev \
    libharfbuzz-dev \
    libmpg123-dev \
    libopencv-dev \
    libopus-dev \
    libopusfile-dev \
    libsoundtouch-dev \
    libswresample-dev \
    libtiff-dev \
    libturbojpeg0-dev \
    libvorbis-dev \
    libwebp-dev \
    libxft-dev \
    uuid-dev \
    xorg-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建Siv3D库
WORKDIR /app/Linux
RUN mkdir build && cd build && \
    cmake -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo \
          -DSIV3D_CXX_FLAGS="-Wall -Wextra -Wno-unknown-pragmas -fPIC" \
          -DSIV3D_C_FLAGS="-Wall -Wextra -Wno-missing-field-initializers -fPIC" \
          -DSIV3D_CXX_FLAGS_RELEASE="-O2 -DNDEBUG" \
          -DSIV3D_C_FLAGS_RELEASE="-O2 -DNDEBUG" \
          -DSIV3D_CXX_FLAGS_RELWITHDEBINFO="-g3 -Og -pg" \
          -DSIV3D_C_FLAGS_RELWITHDEBINFO="-g3 -Og -pg" .. && \
    ninja && \
    ninja install

# 构建测试应用
WORKDIR /app/Linux/App
RUN mkdir build && cd build && \
    cmake -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && \
    ninja

# 运行测试
CMD ["ctest", "--output-on-failure", "--verbose"]