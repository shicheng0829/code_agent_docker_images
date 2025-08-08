FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libx11-dev \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 构建项目
RUN make

# 默认命令为运行stress测试
CMD ["./stress"]

# 开发人员可以使用以下命令进行交互式开发：
# docker run -it --rm libschrift-dev bash