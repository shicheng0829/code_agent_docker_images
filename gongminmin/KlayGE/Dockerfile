FROM ubuntu:22.04

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    python3 \
    python3-pip \
    git \
    wget \
    libx11-dev \
    libgl1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 配置Git用户信息（解决之前的错误）
RUN git config --global user.email "docker@example.com" && \
    git config --global user.name "Docker Builder"

# 修改Build.py以支持aarch64架构
RUN sed -i 's/elif (self.host_arch == "ARM64"):/elif (self.host_arch == "ARM64") or (self.host_arch == "aarch64"):/g' Build.py && \
    sed -i 's/self.host_arch = "arm64"/self.host_arch = "arm64"/g' Build.py && \
    sed -i 's/Unknown host architecture {}/Unknown host architecture {} - treating as arm64/g' Build.py

# 构建项目（只构建测试）
RUN python3 Build.py ninja gcc arm64 Debug

# 运行测试
CMD ["./Build/ninja_gcc11_linux_arm64-Debug/bin/linux_arm64/Tests_d"]