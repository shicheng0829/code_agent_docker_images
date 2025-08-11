FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    ninja-build \
    git \
    curl \
    zip \
    unzip \
    tar \
    pkg-config \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装GCC和Clang编译器
RUN apt-get update && apt-get install -y \
    gcc-11 \
    g++-11 \
    clang-14 \
    && rm -rf /var/lib/apt/lists/*

# 设置默认编译器
ENV CC=gcc-11
ENV CXX=g++-11

# 安装Python（vcpkg需要）
RUN apt-get update && apt-get install -y \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 升级CMake到3.23或更高版本
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
    && apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" \
    && apt-get update \
    && apt-get install -y kitware-archive-keyring \
    && apt-get install -y cmake

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化并引导vcpkg
RUN git submodule update --init \
    && ./vcpkg/bootstrap-vcpkg.sh

# 构建项目（启用所有格式和支持测试）
RUN cmake -S . -B build -G Ninja \
    -DCMAKE_CXX_STANDARD=20 \
    -DCMAKE_BUILD_TYPE=Release \
    -DREFLECTCPP_ALL_FORMATS=ON \
    -DREFLECTCPP_BUILD_TESTS=ON \
    && cmake --build build -j4

# 运行测试
CMD ["ctest", "--test-dir", "build", "--output-on-failure"]