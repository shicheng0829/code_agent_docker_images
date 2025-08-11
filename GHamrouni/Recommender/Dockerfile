FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    make \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 构建项目
RUN make all

# 默认运行测试套件
CMD ["./test_suite.sh"]

# 提供一个可用于交互式开发的入口点
# 使用 docker run -it --entrypoint /bin/bash recommender-dev 来进入容器