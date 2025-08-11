FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    sed \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 修改CMakeLists.txt文件，移除-Werror标志以避免编译警告被视为错误
RUN sed -i 's/-Werror//g' test/CMakeLists.txt

# 默认命令：构建并运行测试
CMD ["/bin/bash", "-c", "cd test && mkdir -p build && cd build && cmake .. && make && ctest --output-on-failure"]