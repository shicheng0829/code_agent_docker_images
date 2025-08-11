FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
# - build-essential: 包含GCC、G++、Make等基本编译工具
# - cmake: 构建系统生成器
# - git: 版本控制系统
# - wget: 网络下载工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译测试
# - JSON_BuildTests=On: 启用测试构建
# - cmake --build . --parallel 4: 使用4个并行任务构建
RUN mkdir build && cd build && \
    cmake .. -DJSON_BuildTests=On && \
    cmake --build . --parallel 4

# 默认运行测试
# ctest --output-on-failure: 运行测试并在失败时显示输出
CMD ["sh", "-c", "cd build && ctest --output-on-failure"]

# 开发者可以使用以下命令进行交互式开发：
# docker run -it --rm -v $(pwd):/app json-dev bash
#
# 或者只运行特定的测试：
# docker run --rm json-dev sh -c "cd build && ctest -R test-name"