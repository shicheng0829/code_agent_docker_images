# Dockerfile for sqlite_orm development and testing
# 
# 构建镜像:
#   docker build -t sqlite_orm_dev .
#
# 使用不同的C++标准构建:
#   docker build -t sqlite_orm_dev_cpp17 --build-arg CMAKE_CXX_STANDARD=17 .
#
# 运行测试:
#   docker run --rm sqlite_orm_dev
#
# 使用不同的构建类型运行:
#   docker run --rm -e CMAKE_BUILD_TYPE=Release sqlite_orm_dev

FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libsqlite3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir compile

# 默认参数
# CMAKE_BUILD_TYPE: Debug 或 Release
# CMAKE_CXX_STANDARD: 14, 17, 或 20
ARG CMAKE_BUILD_TYPE=Debug
ARG CMAKE_CXX_STANDARD=14
ENV CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}

# 配置CMake
# - 使用Ninja作为构建工具
# - 设置构建类型(Debug/Release)
# - 设置C++标准(14/17/20)
# - 启用测试构建
RUN cd compile && cmake -G Ninja \
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE} \
    -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD} \
    -DBUILD_TESTING=ON \
    ..

# 构建项目和测试
RUN cd compile && cmake --build . --config ${CMAKE_BUILD_TYPE} -- -k 10

# 设置默认命令为运行测试
# 可以通过环境变量覆盖构建类型
CMD ["sh", "-c", "cd compile && ctest --output-on-failure -C ${CMAKE_BUILD_TYPE}"]