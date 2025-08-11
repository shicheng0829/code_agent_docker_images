FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    make \
    g++ \
    python3 \
    python3-dev \
    python3-pip \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 安装Python依赖
RUN pip3 install pybind11 setuptools setuptools_scm[toml] wheel

# 构建C++测试程序
RUN make

# 安装Python包（用于Python绑定测试）
# 设置版本环境变量以避免setuptools-scm错误
ENV SETUPTOOLS_SCM_PRETEND_VERSION=0.1.0
RUN pip3 install -e .

# 设置脚本权限
RUN chmod +x run_tests.sh test_python.py

# 默认运行所有测试
CMD ["./run_tests.sh"]