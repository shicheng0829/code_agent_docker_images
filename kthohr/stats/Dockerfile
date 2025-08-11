FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖：
# - build-essential: 包含编译C++程序所需的基本工具
# - cmake: 构建系统
# - g++/gcc: GNU编译器
# - gfortran: Fortran编译器（某些数学库需要）
# - git: 版本控制工具
# - libblas-dev/liblapack-dev: 数值计算库
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    gcc \
    gfortran \
    git \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 克隆并安装GCEM依赖（StatsLib的依赖项）
RUN git clone https://github.com/kthohr/gcem ./gcem
ENV GCEM_INCLUDE_PATH=/app/gcem/include

# 复制当前项目到容器中
COPY . /app/stats

# 设置工作目录为测试目录
WORKDIR /app/stats/tests

# 准备测试环境
RUN ./setup

# 默认提供一个交互式shell用于开发
CMD ["/bin/bash"]