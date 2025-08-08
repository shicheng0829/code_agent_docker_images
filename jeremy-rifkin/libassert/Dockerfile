FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    gcc-10 \
    g++-10 \
    libgcc-10-dev \
    clang-14 \
    clang-tools-14 \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装Python依赖
RUN pip3 install git+https://github.com/jeffkaufman/icdiff.git

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目（Debug模式）
RUN mkdir -p build && \
    cd build && \
    cmake .. \
        -GNinja \
        -DCMAKE_BUILD_TYPE=Debug \
        -DCMAKE_CXX_COMPILER=g++-10 \
        -DLIBASSERT_DESIRED_CXX_STANDARD="cxx_std_17" \
        -DLIBASSERT_BUILD_SHARED=OFF \
        -DCPPTRACE_BUILD_SHARED=ON \
        -DLIBASSERT_BUILD_TESTING=On \
        -DLIBASSERT_WERROR_BUILD=On \
        -DLIBASSERT_DISABLE_CXX_20_MODULES=On && \
    ninja

# 运行测试
CMD ["bash", "-c", "cd build && CTEST_OUTPUT_ON_FAILURE=1 ninja test"]