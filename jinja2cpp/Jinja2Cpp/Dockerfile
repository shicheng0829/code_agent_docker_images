FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    libboost-all-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 安装 CMake 3.23
RUN wget https://github.com/Kitware/CMake/releases/download/v3.23.0/cmake-3.23.0-linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.23.0-linux-x86_64.tar.gz && \
    cp -r cmake-3.23.0-linux-x86_64/* /usr/local/ && \
    rm -rf cmake-3.23.0-linux-x86_64*

# 设置工作目录
WORKDIR /usr/src/jinja2cpp

# 复制源代码到容器中
COPY . .

# 创建构建目录并进入
RUN mkdir build && cd build

# 在构建目录中运行 CMake 配置和构建命令
RUN cd build && cmake .. -DJINJA2CPP_BUILD_TESTS=ON -DJINJA2CPP_DEPS_MODE=internal && \
    cmake --build . --target all

# 运行测试
CMD ["cd", "build", "&&", "ctest", "-V"]