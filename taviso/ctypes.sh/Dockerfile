FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装编译和测试所需的依赖项
RUN apt-get update && apt-get install -y \
    autoconf \
    libltdl-dev \
    libffi-dev \
    libelf-dev \
    elfutils \
    libdw-dev \
    pkg-config \
    build-essential \
    bash \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN ./autogen.sh && \
    ./configure && \
    make

# 使测试脚本可执行
RUN chmod +x run-tests.sh

# 默认命令：运行测试
CMD ["./run-tests.sh"]