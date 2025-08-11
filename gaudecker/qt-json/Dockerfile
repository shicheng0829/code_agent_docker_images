FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装Qt开发工具和其他依赖项
RUN apt-get update && apt-get install -y \
    qt5-default \
    qt5-qmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建示例程序
RUN qmake qt-json.pro && make

# 复制示例JSON文件到构建目录
RUN cp example/example.json example/complex.json ./

# 运行示例程序作为测试
CMD ["sh", "-c", "./qt-json-example"]