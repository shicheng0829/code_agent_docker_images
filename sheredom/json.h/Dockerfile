FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gcc \
    g++ \
    clang \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 给开发脚本添加执行权限
RUN chmod +x dev.sh

# 默认命令：构建并运行测试
CMD ["./dev.sh"]

# 开发命令示例：
# 构建项目: docker run --rm -v $(pwd):/app json-h-dev ./dev.sh build
# 运行测试: docker run --rm -v $(pwd):/app json-h-dev ./dev.sh test
# 交互式开发: docker run -it -v $(pwd):/app json-h-dev ./dev.sh dev
# 清理构建: docker run --rm -v $(pwd):/app json-h-dev ./dev.sh clean