FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 下载并安装doctest头文件到tests目录
RUN wget https://github.com/doctest/doctest/releases/download/v2.4.9/doctest.h -O tests/doctest.h

# 设置编译器标志，使用C++20标准
ENV CXXFLAGS="-std=c++20 -O2"

# 编译测试程序，需要先编译oof库的实现部分
RUN g++ $CXXFLAGS -DOOF_IMPL -o demos/implementations.o -c demos/implementations.cpp && \
    g++ $CXXFLAGS -o tests/tests.o -c tests/tests.cpp && \
    g++ $CXXFLAGS -o tests/core_tests.o -c tests/core_tests.cpp && \
    g++ $CXXFLAGS -o tests/cell_pos_tests.o -c tests/cell_pos_tests.cpp && \
    g++ $CXXFLAGS -o tests/run_tests demos/implementations.o tests/tests.o tests/core_tests.o tests/cell_pos_tests.o

# 运行测试作为构建的一部分
CMD ["./tests/run_tests"]