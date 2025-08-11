FROM ubuntu:24.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    libmbedtls-dev \
    libwolfssl-dev \
    git \
    # 添加网络工具用于调试
    iproute2 \
    iputils-ping \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建构建目录并配置CMake
# 使用mbed TLS引擎启用TLS支持
# 启用测试以确保所有测试都能运行
RUN mkdir build.mbed && cd build.mbed && \
    cmake -G Ninja -DCMAKE_BUILD_TYPE=Debug -D NNG_ENABLE_TLS=ON -DNNG_TLS_ENGINE=mbed -DNNG_TESTS=ON .. && \
    ninja

# 默认命令：运行测试套件
# 注意：某些网络相关的测试可能会因为容器环境限制而失败
# 这是正常的，不会影响核心功能
CMD ["sh", "-c", "cd build.mbed && ctest --output-on-failure"]

# 提供一个可选的入口点来启动交互式shell
# 可以使用 docker run -it nng-dev bash 来进入容器进行调试

# 要运行特定的测试，可以使用以下命令：
# docker run --rm nng-dev sh -c "cd build.mbed && ctest -R <test_pattern> --output-on-failure"

# 要在容器中进行开发，可以使用以下命令挂载本地目录：
# docker run -it -v $(pwd):/app nng-dev bash