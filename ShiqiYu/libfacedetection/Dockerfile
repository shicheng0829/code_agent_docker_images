FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libopencv-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建库和示例程序
# 注意：我们针对ARM64架构进行了优化：
# 1. 启用了NEON指令集支持（ARM的SIMD指令集）
# 2. 禁用了AVX2和AVX512（这些是Intel/AMD x86-64架构特有的指令集）
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DDEMO=ON -DENABLE_NEON=ON -DENABLE_AVX2=OFF -DENABLE_AVX512=OFF && \
    make -j$(nproc)

# 设置默认命令
# 使用ENTRYPOINT和CMD组合提供灵活的命令执行方式
# 示例用法:
#   docker run --rm libfacedetection-dev                    # 运行默认基准测试
#   docker run --rm libfacedetection-dev ls -la             # 列出文件
ENTRYPOINT ["bash", "-c"]
CMD ["cd build && ./benchmark ../images/cnnresult.png"]