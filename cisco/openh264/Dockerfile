FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    nasm \
    g++-multilib \
    gcc-multilib \
    libc6-dev-i386 \
    python3-pip \
    python3-setuptools \
    git \
    && rm -rf /var/lib/apt/lists/*

# 安装meson和ninja
RUN python3 -m pip install meson==0.52.1 ninja

# 设置工作目录
WORKDIR /openh264

# 复制源代码到容器中
COPY . .

# 构建项目
RUN make gmp-bootstrap && \
    make gtest-bootstrap && \
    meson builddir && \
    ninja -C builddir -v

# 默认命令是运行单元测试
CMD ["meson", "test", "-C", "builddir", "-v"]

# 可选：提供一个交互式shell用于开发
# 使用 docker run -it openh264-dev bash 来进入开发环境