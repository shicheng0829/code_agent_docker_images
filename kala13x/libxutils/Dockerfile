FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 复制测试脚本
COPY test_libxutils.sh /app/

# 构建库
RUN ./build.sh

# 构建示例程序（包含测试）
RUN ./build.sh --examples

# 运行测试脚本以验证构建
RUN chmod +x /app/test_libxutils.sh && /app/test_libxutils.sh

# 默认命令：运行测试脚本
CMD ["/app/test_libxutils.sh"]