FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    curl \
    zip \
    unzip \
    tar \
    libgtest-dev \
    software-properties-common \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 安装较新版本的CMake和Ninja
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository "deb https://apt.kitware.com/ubuntu/ focal main" && \
    apt-get update && \
    apt-get install -y cmake ninja-build

# 安装vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git /opt/vcpkg
RUN /opt/vcpkg/bootstrap-vcpkg.sh

# 设置环境变量
ENV VCPKG_ROOT=/opt/vcpkg
ENV VCPKG_FORCE_SYSTEM_BINARIES=1

# 复制项目文件
WORKDIR /app
COPY . .

# 使用vcpkg安装依赖项（从vcpkg.json文件中读取）
RUN $VCPKG_ROOT/vcpkg install

# 构建项目
RUN mkdir build && cd build && \
    cmake .. -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake \
    -DVCPKG_TARGET_TRIPLET=x64-linux \
    -DBUILD_TESTS=ON \
    -DBUILD_RAPIDJSON_ARCHIVE=ON \
    -DBUILD_PUGIXML_ARCHIVE=ON \
    -DBUILD_RAPIDYAML_ARCHIVE=ON \
    -DBUILD_CSV_ARCHIVE=ON \
    -DBUILD_MSGPACK_ARCHIVE=ON && \
    ninja

# 运行测试
CMD ["ctest", "--test-dir", "build", "-T", "test", "--output-on-failure", "-j4"]