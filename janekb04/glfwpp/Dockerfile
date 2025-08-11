FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libxrandr-dev \
    libxinerama-dev \
    libx11-dev \
    libxcursor-dev \
    libxi-dev \
    libxext-dev \
    libegl1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 创建构建目录
RUN mkdir build

# 构建项目
WORKDIR /app/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN cmake --build . --config Release --target glfwpp_all_examples

# 复制测试脚本到构建目录
COPY run_tests.sh /app/build/

# 使测试脚本可执行
RUN chmod +x /app/build/run_tests.sh

# 默认运行测试
CMD ["./run_tests.sh"]