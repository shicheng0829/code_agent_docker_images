# 开发用Dockerfile，用于运行MinUnit的单元测试
# 基于Ubuntu 20.04 LTS

FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
# - build-essential: 包含make、gcc等基本构建工具
# - gcc: GNU编译器集合
# - clang: LLVM编译器前端
# - make: 构建工具
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    clang \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令：进入ci目录并运行测试
# 这会编译minunit_example并运行check_example.sh脚本验证测试结果
CMD ["bash", "-c", "cd ci && make && ./check_example.sh"]