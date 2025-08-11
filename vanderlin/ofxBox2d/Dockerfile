FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libasound2-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libjack-jackd2-dev \
    libpulse-dev \
    libsndfile1-dev \
    libudev-dev \
    libx11-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxxf86vm-dev \
    pkg-config \
    wget \
    curl \
    freeglut3-dev \
    libglu1-mesa-dev \
    libgl1-mesa-dev \
    libraw1394-dev \
    libudev-dev \
    libdrm-dev \
    libglew-dev \
    libopenal-dev \
    libsndfile-dev \
    libfreeimage-dev \
    libcairo2-dev \
    libfreetype6-dev \
    libssl-dev \
    libusb-1.0-0-dev \
    libgtk-3-dev \
    libopencv-dev \
    libassimp-dev \
    librtaudio-dev \
    libboost-filesystem1.71-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    gstreamer1.0-libav \
    gstreamer1.0-pulseaudio \
    gstreamer1.0-x \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-alsa \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gdb \
    libglfw3-dev \
    liburiparser-dev \
    libcurl4-openssl-dev \
    libpugixml-dev \
    libgconf-2-4 \
    libgtk2.0-0 \
    libpoco-dev \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /opt

# 下载并安装OpenFrameworks
RUN wget https://openframeworks.cc/versions/v0.11.2/of_v0.11.2_linux64gcc6_release.tar.gz \
    && tar -xzf of_v0.11.2_linux64gcc6_release.tar.gz \
    && rm of_v0.11.2_linux64gcc6_release.tar.gz

# 设置OpenFrameworks路径
ENV OF_ROOT=/opt/of_v0.11.2_linux64gcc6_release

# 编译OpenFrameworks
WORKDIR $OF_ROOT
RUN cd scripts/linux && ./compileOF.sh -j$(nproc)

# 复制ofxBox2d插件到OpenFrameworks addons目录
WORKDIR /opt
COPY . $OF_ROOT/addons/ofxBox2d

# 设置工作目录为ofxBox2d示例
WORKDIR $OF_ROOT/addons/ofxBox2d/example-Simple

# 编译示例程序作为测试
RUN make -j$(nproc)

# 运行示例程序（非图形模式）
CMD ["make", "run"]