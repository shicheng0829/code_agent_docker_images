# 使用Ubuntu作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ARG DEBIAN_FRONTEND=noninteractive

# 安装必要的工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 创建构建目录并编译项目（包括测试）
# 禁用gtest_disable_pthreads选项以确保正确链接pthread库
RUN mkdir -p build && \
    cd build && \
    cmake -DTEST=ON -Dgtest_disable_pthreads=OFF .. && \
    make

# 默认运行所有测试
CMD ["bash", "-c", "cd /app/build && ./test/test_exe || true"]