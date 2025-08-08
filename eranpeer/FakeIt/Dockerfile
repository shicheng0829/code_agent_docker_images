# FakeIt 开发和测试环境 Docker 镜像
# 此镜像包含完整的构建工具链，并预编译了 FakeIt 及其测试套件
FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目和测试
RUN cmake -S . -B build \
    -DCMAKE_BUILD_TYPE=Debug \
    -DENABLE_TESTING=ON \
    && cmake --build build -j

# 运行测试作为验证步骤
RUN build/tests/FakeIt_tests

# 默认命令
CMD ["/bin/bash"]