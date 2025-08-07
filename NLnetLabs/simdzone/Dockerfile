FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    autotools-dev \
    autoconf \
    automake \
    libtool \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装Conan包管理器
RUN pip3 install conan --upgrade

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装项目依赖
RUN conan profile detect || true
RUN conan install -b missing conanfile.txt

# 构建项目（包括测试）
# 手动设置C编译器和链接器标志来包含cmocka头文件和库
RUN CMOCKA_BASE_DIR=$(find /root/.conan2 -name "cmocka.h" -type f | sed 's|/include/cmocka.h||') && \
    CMOCKA_INCLUDE_DIR="$CMOCKA_BASE_DIR/include" && \
    CMOCKA_LIB_DIR="$CMOCKA_BASE_DIR/lib" && \
    cmake -DCMAKE_BUILD_TYPE=Debug \
          -DBUILD_TESTING=on \
          -DCMAKE_MODULE_PATH="/app" \
          -DCMAKE_PREFIX_PATH="/app" \
          -DCMAKE_C_FLAGS="-I$CMOCKA_INCLUDE_DIR" \
          -DCMAKE_EXE_LINKER_FLAGS="-L$CMOCKA_LIB_DIR -Wl,-rpath,$CMOCKA_LIB_DIR" \
          -DCMAKE_SHARED_LINKER_FLAGS="-L$CMOCKA_LIB_DIR -Wl,-rpath,$CMOCKA_LIB_DIR" \
          . && \
    cmake --build . -- -j$(nproc)

# 运行测试
CMD ["ctest", "-j$(nproc)", "--output-on-failure"]