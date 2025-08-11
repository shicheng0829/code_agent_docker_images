FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和测试所需的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    python3-pip \
    libpng-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装meson
RUN pip3 install meson

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目并启用开发模式（包含测试）
RUN meson setup build -Ddev_build=true -Dwarning_level=3 && \
    meson compile -C build

# 运行测试
CMD ["meson", "test", "-C", "build", "--verbose"]