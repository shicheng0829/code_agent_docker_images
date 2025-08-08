FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libcurl4-gnutls-dev \
    curl \
    ca-certificates \
    git \
    sudo && \
    rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目
RUN make

# 添加测试用户避免使用root运行测试
RUN useradd -m tester && \
    echo "tester ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 设置正确的权限以便测试用户可以写入
RUN chown -R tester:tester /app

# 切换到测试用户
USER tester
WORKDIR /app

# 默认命令是运行测试
CMD ["make", "test"]