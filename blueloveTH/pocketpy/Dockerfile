FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    python3 \
    python3-pip \
    git \
    curl \
    lcov \
    llvm \
    && rm -rf /var/lib/apt/lists/*

# 创建python命令的符号链接
RUN ln -s /usr/bin/python3 /usr/bin/python

# 设置工作目录
WORKDIR /app

# 复制项目文件（包括.git目录以支持子模块）
COPY . .

# 初始化并更新Git子模块
RUN git submodule update --init --recursive

# 安装Python依赖（如果有的话）
RUN pip3 install -r requirements.txt || echo "No requirements.txt found"

# 构建项目
RUN python3 prebuild.py
RUN python3 cmake_build.py

# 默认运行单元测试
CMD ["python3", "scripts/run_tests.py"]