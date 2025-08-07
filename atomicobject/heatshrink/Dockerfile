FROM alpine:latest

# 安装构建工具和依赖
RUN apk add --no-cache \
    build-base \
    clang \
    gcc \
    make \
    libc-dev

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 默认运行测试
CMD ["make", "test"]

# 开发者可以使用以下命令进行交互式开发：
# docker run -it --rm -v $(pwd):/app heatshrink-test sh