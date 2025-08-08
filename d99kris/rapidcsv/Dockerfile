FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    locales \
    && rm -rf /var/lib/apt/lists/*

# 生成德语locale（根据CI配置需要）
RUN locale-gen de_DE.UTF-8

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令：构建项目并运行所有测试
CMD ["tests"]

# 提供一个可选的入口点来运行特定命令
ENTRYPOINT ["./make.sh"]