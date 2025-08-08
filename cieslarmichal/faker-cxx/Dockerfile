FROM ubuntu:24.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    gcc-13 \
    g++-13 \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# 创建Python虚拟环境并安装Conan
RUN python3 -m venv /opt/conan-env
ENV PATH="/opt/conan-env/bin:$PATH"
RUN pip install conan

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 配置Conan配置文件
RUN CC=gcc-13 CXX=g++-13 conan profile detect --force --name gcc-13

# 安装Conan依赖项
RUN conan install conanfile.txt \
    -r conancenter \
    -pr:b gcc-13 \
    -pr:h gcc-13 \
    -s compiler.cppstd=20 \
    -s build_type=Debug \
    -c:b tools.build:compiler_executables="{'c': '/usr/bin/gcc-13', 'cpp': '/usr/bin/g++-13'}" \
    -c:h tools.build:compiler_executables="{'c': '/usr/bin/gcc-13', 'cpp': '/usr/bin/g++-13'}" \
    -o "*:shared=True" \
    --build=missing

# 配置CMake
RUN cmake -S . --preset=unixlike-gcc-debug-shared \
    -DCMAKE_C_COMPILER=gcc-13 \
    -DCMAKE_CXX_COMPILER=g++-13 \
    -DBUILD_TESTING:BOOL=ON \
    -DUSE_STD_FORMAT:BOOL=ON \
    -DUSE_SYSTEM_DEPENDENCIES:BOOL=ON \
    -DCMAKE_TOOLCHAIN_FILE=build/Debug/generators/conan_toolchain.cmake

# 构建项目
RUN cmake --build --preset=unixlike-gcc-debug-shared

# 默认命令运行测试
CMD ["ctest", "--preset=unixlike-gcc-debug-shared"]