FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3 \
    python3-pip \
    python3-dev \
    libeigen3-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装Python包
RUN pip3 install numpy pybind11

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 配置Quantum++
RUN cmake -B build

# 构建单元测试
RUN cmake --build build --target unit_tests --parallel 8

# 默认命令：运行单元测试（排除qpp_Timer测试）
CMD ["build/SYSTEM/unit_tests", "--gtest_filter=-qpp_Timer*"]