# 使用Ubuntu 20.04作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
# - build-essential: 包含make、gcc等基本构建工具
# - g++: C++编译器
# - cmake: 构建系统
# - python3: 用于处理基准测试结果的脚本
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    cmake \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户以提高安全性
# 用户ID设置为1000，这是大多数Linux系统的默认用户ID
RUN useradd -m -u 1000 user
USER user
WORKDIR /home/user/app

# 将源代码复制到容器中
# 使用--chown确保文件所有权正确设置
COPY --chown=user:user . .

# 设置开发脚本权限
RUN chmod +x dev.sh

# 编译基准测试程序
# 使用C++11标准和优化选项
RUN g++ -std=c++11 -O2 -m64 -march=native bench/bench.cpp -o bench/pdqsort_bench

# 默认命令是运行基准测试
# 可以通过覆盖CMD来使用其他命令，例如：
# docker run --rm pdqsort-dev ./dev.sh --help
CMD ["./bench/pdqsort_bench"]