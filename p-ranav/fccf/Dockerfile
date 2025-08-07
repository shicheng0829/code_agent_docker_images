FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libclang-10-dev \
    libclang-cpp10 \
    llvm-10-dev \
    llvm-10-tools \
    libclang-common-10-dev \
    clang-10 \
    python3 \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装Python依赖
RUN pip3 install codespell

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 修复CMakeLists.txt文件
# 1. 将add_clang_executable替换为add_executable
# 2. 注释掉include(AddClang)行
RUN sed -i 's/add_clang_executable/add_executable/g' CMakeLists.txt && \
    sed -i 's/include(AddClang)/# include(AddClang)/g' CMakeLists.txt

# 构建项目
RUN cmake -S . -B build -D CMAKE_BUILD_TYPE=Release -D fccf_DEVELOPER_MODE=ON
RUN cmake --build build

# 运行测试
CMD ["cmake", "--build", "build", "--target", "test"]