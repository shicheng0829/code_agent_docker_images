FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    git \
    wget \
    lsb-release \
    software-properties-common \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# 安装最新的Clang编译器（版本19）
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod u+x llvm.sh && \
    ./llvm.sh 19 && \
    rm llvm.sh

# 安装Python依赖
RUN pip3 install seaborn

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p Build

# 配置CMake（启用基准测试而不是测试）
# 使用C++20标准和适当的编译器标志
RUN cmake -S . -B ./Build \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=/usr/bin/clang++-19 \
    -DCMAKE_CXX_STANDARD=20 \
    -DJSONIFIER_BENCHMARKS="TRUE"

# 构建项目
RUN cmake --build ./Build --config=Release -j$(nproc)

# 安装项目
RUN cmake --install ./Build --config=Release

# 设置默认命令
CMD ["./Build/Benchmarks/Json-Performance"]