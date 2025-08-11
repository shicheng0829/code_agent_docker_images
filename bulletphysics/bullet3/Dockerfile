FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libglew-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libx11-dev \
    libxext-dev \
    libxmu-dev \
    libxi-dev \
    libxxf86vm-dev \
    python3 \
    python3-dev \
    python3-pip \
    python3-numpy \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 安装Python依赖
RUN pip3 install -r requirements.txt

# 构建项目
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_PYBULLET=ON -DBUILD_UNIT_TESTS=ON && \
    make -j$(nproc)

# 运行单元测试
CMD ["sh", "-c", "cd build && ctest -C Release --output-on-failure"]