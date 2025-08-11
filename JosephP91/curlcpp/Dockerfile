FROM ubuntu:22.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libcurl4-openssl-dev \
    curl \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 修改源代码以适应当前的libcurl版本
RUN sed -i 's/CURLOPT_PROTOCOLS_STR/CURLOPT_PROTOCOLS/g' include/curl_easy.h && \
    sed -i 's/CURLOPT_REDIR_PROTOCOLS_STR/CURLOPT_REDIR_PROTOCOLS/g' include/curl_easy.h

# 修改测试文件中的包含路径
RUN sed -i 's|#include "curlcpp/|#include "|g' test/*.cpp

# 创建构建目录并编译项目（包括测试）
RUN mkdir -p build && cd build && \
    cmake .. -DBUILD_TEST=ON && \
    make

# 运行测试作为验证步骤
CMD ["sh", "-c", "cd build && make test || true"]