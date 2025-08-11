FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    libglew-dev \
    libxrandr-dev \
    libxxf86vm-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxi-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 升级pip并安装python依赖
RUN pip3 install --upgrade pip

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建OpenSubdiv及其依赖项
RUN python3 build_scripts/build_osd.py --tests --onetbb --omp --build /app/build --src /app/src /app/install

# 运行单元测试
CMD ["ctest", "--test-dir", "/app/build/app"]