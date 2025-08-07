FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项和开发工具
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    vim \
    gdb \
    valgrind \
    clang-format \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DCPPTERMINAL_ENABLE_DOCS=OFF && \
    cmake --build . --config Debug --parallel $(nproc)

# 默认运行测试
CMD ["sh", "-c", "cd build && ctest -C Debug --output-on-failure"]