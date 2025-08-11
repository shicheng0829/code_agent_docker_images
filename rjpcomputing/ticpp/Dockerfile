# 使用Ubuntu 20.04作为基础镜像
FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装wget、gnupg和software-properties-common
RUN apt-get update && apt-get install -y \
    wget \
    gpg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# 安装CMake 3.21或更高版本
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' && \
    apt-get update && \
    apt-get install -y cmake

# 安装其他构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    gdb \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录
RUN mkdir -p build

# 进入构建目录并配置项目
WORKDIR /app/build

# 配置CMake项目
RUN cmake ..

# 构建项目
RUN make

# 返回到项目根目录
WORKDIR /app

# 编译单元测试程序
RUN g++ -std=c++17 -I. unit_test.cpp -Lbuild -lticpp -o unit_test

# 运行单元测试程序
RUN ./unit_test

# 提供说明信息
RUN echo '# TiCPP Development Environment\n\n## Features\n- Ubuntu 20.04 base image\n- CMake 3.21+\n- GCC 9.4\n- GDB debugger\n- Valgrind memory checker\n\n## Usage\nTo run the container interactively:\n  docker run -it ticpp-dev\n\nTo build the project manually:\n  cd build && cmake .. && make\n\nTo run tests:\n  ./unit_test\n' > README.docker

# 默认命令
CMD ["/bin/bash"]