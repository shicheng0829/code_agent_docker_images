FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt update && apt install -y \
    build-essential \
    cmake \
    git \
    nlohmann-json3-dev \
    librapidxml-dev \
    freeglut3-dev \
    libglu1-mesa-dev \
    libxmu-dev \
    libxi-dev \
    libglfw3-dev \
    libfreetype-dev \
    libarmadillo-dev \
    libhdf5-dev \
    qtbase5-dev \
    libwxgtk3.0-gtk3-dev \
    libgbm-dev \
    libegl-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake .. -DBUILD_TESTS=ON -DBUILD_EXAMPLES=OFF && \
    cmake --build . --config Release

# 默认运行测试
CMD ["sh", "-c", "cd build && ctest -C Release"]