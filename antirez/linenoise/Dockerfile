FROM alpine:latest

# 安装构建工具和依赖
RUN apk add --no-cache \
    build-base \
    gcc \
    make

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN make

# 运行测试
RUN make test

# 默认命令
CMD ["./linenoise_example"]