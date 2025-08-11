FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目和示例
RUN mkdir build && cd build && cmake ../ -DTLSE_COMPILE_DEFINITIONS="TLS_AMALGAMATION" -DBUILD_EXAMPLES=ON && cmake --build . --verbose

# 创建测试证书目录
RUN mkdir -p testcert

# 默认命令：列出编译后的示例程序
CMD ["bash", "-c", "echo 'TLSe development environment ready.' && echo 'Compiled examples:' && ls -la build/examples"]