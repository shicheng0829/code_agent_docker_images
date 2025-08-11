FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 更换为阿里云镜像源以提高稳定性
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# 更新包列表并安装构建依赖项
RUN apt-get update && apt-get install -y \
    cmake \
    xorg-dev \
    libglu1-mesa-dev \
    python3 \
    python3-pip \
    python3-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化并更新子模块
RUN git submodule update --init --recursive

# 修改CMakeLists.txt以禁用架构优化
RUN sed -i 's/set(NANOGUI_NATIVE_FLAGS_DEFAULT "-march=nehalem")/set(NANOGUI_NATIVE_FLAGS_DEFAULT "")/' CMakeLists.txt

# 安装Python依赖
RUN pip3 install -e .

# 复制测试脚本和示例程序
COPY test_nanogui.py .
COPY example.py .

# 运行测试以验证安装
RUN python3 test_nanogui.py

# 运行单元测试的命令
CMD ["python3", "-m", "pytest"]