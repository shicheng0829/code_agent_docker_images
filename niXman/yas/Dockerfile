FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /usr/src/app

# 下载并安装Abseil
ENV ABSEIL_VERSION=20200923.2
ENV ABSEIL_HOME=/usr/src/abseil-cpp
RUN git clone --depth 1 --branch "${ABSEIL_VERSION}" https://github.com/abseil/abseil-cpp.git "${ABSEIL_HOME}"

# 下载并安装Boost
ENV BOOST_VERSION=1.76.0
ENV BOOST_PATH=/usr/src/boost
# 使用SourceForge镜像下载Boost
RUN cd /tmp && \
    BOOST_VERSION_UNDERSCORE=$(echo ${BOOST_VERSION} | tr . _) && \
    wget https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION_UNDERSCORE}.tar.bz2/download -O boost_${BOOST_VERSION_UNDERSCORE}.tar.bz2 && \
    tar -xjf boost_${BOOST_VERSION_UNDERSCORE}.tar.bz2 && \
    mv boost_${BOOST_VERSION_UNDERSCORE} ${BOOST_PATH} && \
    rm boost_${BOOST_VERSION_UNDERSCORE}.tar.bz2

# 复制源代码
COPY . /usr/src/app/yas

# 修改CMakeLists.txt以包含Boost路径和其他必要的修改
RUN sed -i 's|include_directories(|include_directories(\n    ${BOOST_PATH}\n|g' /usr/src/app/yas/tests/base/CMakeLists.txt && \
    # 添加编译器标志以忽略narrowing转换警告
    sed -i 's|-Wall -Wextra|-Wall -Wextra -Wno-narrowing|g' /usr/src/app/yas/tests/base/CMakeLists.txt

# 创建构建目录
WORKDIR /usr/src/app/build

# 配置CMake
RUN cmake -S /usr/src/app/yas/tests/base -B . \
    -DCMAKE_BUILD_TYPE=Release \
    -DYAS_SERIALIZE_ABSL_TYPES=TRUE \
    -DYAS_SERIALIZE_BOOST_TYPES=TRUE \
    -DYAS_BUILD_TESTS=ON \
    -DABSEIL_HOME=${ABSEIL_HOME} \
    -DBOOST_PATH=${BOOST_PATH}

# 构建项目
RUN cmake --build . --config Release --parallel

# 默认命令是运行测试
CMD ["ctest", "-C", "Release", "--output-on-failure"]