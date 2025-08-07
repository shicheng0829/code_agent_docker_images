FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 修改测试文件中的PROJECT_BINARY_DIR宏定义，使其指向当前目录
# 这是必要的，因为直接使用g++编译时，CMake的PROJECT_BINARY_DIR变量不可用
RUN sed -i 's/PROJECT_BINARY_DIR/"."/g' tests/AiffLoadingTests.cpp && \
    sed -i 's/PROJECT_BINARY_DIR/"."/g' tests/FileWritingTests.cpp && \
    sed -i 's/PROJECT_BINARY_DIR/"."/g' tests/GeneralTests.cpp && \
    sed -i 's/PROJECT_BINARY_DIR/"."/g' tests/WavLoadingTests.cpp

# 直接编译测试程序
# 使用g++编译所有测试文件，包含必要的头文件路径和预处理器定义
RUN g++ -std=c++17 -I. -Itests -Itests/doctest \
    tests/*.cpp -o AudioFileTests \
    -D_USE_MATH_DEFINES

# 创建测试所需的目录并复制测试音频文件
RUN mkdir -p test-audio && cp -r tests/test-audio/* test-audio/ && \
    mkdir -p audio-write-tests

# 运行单元测试
CMD ["./AudioFileTests"]