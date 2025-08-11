FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    clang \
    git \
    python3 \
    python3-pip \
    python3-venv \
    llvm \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 创建并激活虚拟环境
RUN python3 -m venv .venv && \
    . .venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# 构建项目
RUN mkdir build && cd build && \
    cmake .. -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DGGML_METAL=OFF && \
    cmake --build . --config Release -j $(nproc)

# 默认运行测试
CMD ["/bin/bash", "-c", "cd build && ctest --verbose --timeout 900"]

# 开发命令：
# 构建：docker build -t ggml-dev .
# 运行测试：docker run --rm ggml-dev
# 交互式shell：docker run -it --rm ggml-dev /bin/bash
# 重新构建项目：docker run -it --rm ggml-dev /bin/bash -c "cd build && cmake .. -G Ninja -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DGGML_METAL=OFF && cmake --build . --config Release -j $(nproc)"