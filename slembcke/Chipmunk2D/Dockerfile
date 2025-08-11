FROM ubuntu:20.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libx11-dev \
    libxrandr-dev \
    libxi-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxxf86vm-dev \
    libasound2-dev \
    libpulse-dev \
    libopenal-dev \
    libglew-dev \
    libglfw3-dev \
    libfreetype6-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc)

# 编译测试程序
RUN gcc -I./include test_chipmunk.c ./build/src/libchipmunk.a -lm -ldl -o test_chipmunk

# 默认运行演示程序
CMD ["./build/demo/chipmunk_demos"]