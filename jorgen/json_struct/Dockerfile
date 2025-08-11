FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 默认命令：构建项目并运行测试
CMD ["/bin/bash", "-c", "mkdir -p build && cd build && cmake -DJSON_STRUCT_OPT_BUILD_TESTS=ON -DJSON_STRUCT_OPT_BUILD_EXAMPLES=ON .. && cmake --build . && ctest --output-on-failure"]

# 开发者可以使用以下命令进行交互式开发：
# docker run -it --rm -v $(pwd):/app json_struct_dev /bin/bash