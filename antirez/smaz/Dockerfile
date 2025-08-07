FROM gcc:latest

# 设置工作目录
WORKDIR /app

# 复制所有源代码到容器中
COPY . .

# 安装make工具（如果需要的话）
RUN apt-get update && apt-get install -y make

# 编译测试程序
RUN make clean && make

# 默认运行测试
CMD ["./smaz_test"]