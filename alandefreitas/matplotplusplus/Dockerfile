FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gnuplot \
    libgtk2.0-dev \
    libpango1.0-dev \
    libcairo2-dev \
    libfreetype6-dev \
    libfontconfig1-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    zlib1g-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libglfw3-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建构建目录并编译项目
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release \
             -DMATPLOTPP_BUILD_EXAMPLES=ON \
             -DMATPLOTPP_BUILD_TESTS=ON \
             -DMATPLOTPP_BUILD_SHARED_LIBS=ON && \
    cmake --build . --parallel $(nproc) --config Release

# 运行测试
CMD ["bash", "-c", "cd build && ctest --output-on-failure"]