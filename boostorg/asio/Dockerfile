FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libboost-all-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建并运行测试
CMD ["bash", "-c", "cd test && for f in *.cpp; do echo \"Building $f\" && g++ -std=c++11 -I.. -pthread -lboost_system -lboost_coroutine -lboost_regex -lboost_context \"$f\" -o \"/tmp/test_${f%.cpp}\" && echo \"Running $f\" && timeout 30s \"/tmp/test_${f%.cpp}\" || echo \"Test $f timed out or failed\"; done"]