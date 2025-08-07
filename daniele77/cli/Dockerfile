# CLI库的开发环境Dockerfile
# 支持构建和运行单元测试

FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译依赖项：
# - build-essential: 包含gcc/g++等基本编译工具
# - cmake: 构建系统
# - ninja-build: 快速构建工具
# - libboost-all-dev: Boost库（测试需要）
# - libasio-dev: Asio库（网络功能需要）
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libboost-all-dev \
    libasio-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码文件
# 按修改频率排序，以最大化利用Docker层缓存
COPY CMakeLists.txt README.md LICENSE cli.pc.in cliConfig.cmake.in ./
COPY include/ include/
COPY test/ test/

# 默认构建类型为Debug
ARG BUILD_TYPE=Debug
ENV BUILD_TYPE=${BUILD_TYPE}

# 构建项目和测试
# 使用Ninja生成器以获得更快的构建速度
RUN mkdir build && cd build && \
    cmake .. -G "Ninja Multi-Config" \
    -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
    -DCMAKE_CXX_STANDARD=14 \
    -DCLI_BuildTests=ON \
    -DCLI_UseBoostAsio=ON && \
    cmake --build . --config ${BUILD_TYPE}

# 运行测试作为健康检查
# 使用--output-on-failure选项显示失败测试的详细信息
CMD ctest --test-dir build -C ${BUILD_TYPE} --output-on-failure