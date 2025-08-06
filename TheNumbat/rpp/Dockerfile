FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    lsb-release \
    software-properties-common \
    cmake \
    make \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安装Clang 17
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 17 && \
    rm llvm.sh

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 构建项目（发布模式）
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DRPP_TEST=ON -DCMAKE_CXX_COMPILER=clang++-17 && \
    cmake --build build -- -j

# 运行测试以验证构建
RUN ctest --test-dir build --output-on-failure

# 默认运行测试
CMD ["ctest", "--test-dir", "build", "--output-on-failure"]