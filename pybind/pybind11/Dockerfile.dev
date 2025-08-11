FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    python3-dev \
    python3-pip \
    python3-numpy \
    python3-pytest \
    libeigen3-dev \
    libboost-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 升级pip并安装测试所需的Python包
RUN pip3 install --upgrade pip
COPY tests/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN cmake -S . -B build \
    -DPYBIND11_WERROR=ON \
    -DPYBIND11_PYTEST_ARGS=-v \
    -DDOWNLOAD_CATCH=ON \
    -DDOWNLOAD_EIGEN=ON

RUN cmake --build build

# 默认命令是运行测试
CMD ["cmake", "--build", "build", "--target", "pytest"]