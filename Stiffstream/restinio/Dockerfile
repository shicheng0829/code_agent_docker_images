FROM ubuntu:24.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ruby \
    gem \
    g++-13 \
    clang-18 \
    libboost-all-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/app

# 复制源代码
COPY . .

# 安装 Mxx_ru
RUN gem install Mxx_ru

# 获取外部依赖项
RUN mxxruexternals

# 创建构建目录
RUN mkdir -p dev/_build_test

# 设置环境变量以匹配CI中的Ubuntu构建作业
ENV RESTINIO_BUILD_DIR=_build_test
ENV CC=gcc-13
ENV CXX=g++-13
ENV AR=gcc-ar-13
ENV RESTINIO_BUILD_TAG=gcc-13_cpp20_Debug_standalone_asio

# 配置、构建和测试
WORKDIR /usr/src/app/dev
RUN cmake \
    -B ${RESTINIO_BUILD_DIR} \
    -DCMAKE_BUILD_TYPE=Debug \
    -DRESTINIO_EXPLICIT_CPPSTD=20 \
    -DRESTINIO_TEST_SUFFIX=" [${RESTINIO_BUILD_TAG}]"

RUN cmake \
    --build ${RESTINIO_BUILD_DIR} \
    --parallel $(nproc) \
    --verbose

CMD ["ctest", "-T", "test", "--test-dir", "_build_test", "--output-on-failure", "--no-compress-output"]