FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    zip \
    unzip \
    tar \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git
RUN ./vcpkg/bootstrap-vcpkg.sh

# 使用项目中的vcpkg.json文件安装依赖项
RUN ./vcpkg/vcpkg install

# 创建构建目录
RUN mkdir build

# 配置CMake
RUN cd build && cmake .. -DCMAKE_TOOLCHAIN_FILE=/app/vcpkg/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Debug -DCPP_JWT_USE_VENDORED_NLOHMANN_JSON=off

# 构建项目
RUN cd build && cmake --build . --config Debug --parallel 2

# 运行测试
CMD cd build && ctest -C Debug -T test --parallel 2 --output-on-failure --timeout 200