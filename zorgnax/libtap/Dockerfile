FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gcc \
    clang \
    libtest-differences-perl \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 构建项目
RUN make

# 注意：由于在某些架构（如ARM）上整数除零不会导致程序崩溃，
# dies_ok 测试可能会失败。这是正常现象，不是代码问题。

# 复制测试脚本
COPY run_tests.sh /app/

# 运行测试
CMD ["./run_tests.sh"]