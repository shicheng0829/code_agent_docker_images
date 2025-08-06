FROM alpine:latest

# 安装构建工具和依赖
RUN apk add --no-cache \
    build-base \
    make \
    gcc \
    musl-dev \
    linux-headers

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目并运行测试
CMD ["make", "check"]