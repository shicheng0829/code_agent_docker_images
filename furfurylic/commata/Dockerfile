FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 创建非root用户
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer/app

# 复制源代码到容器中
COPY --chown=developer:developer . .

# 构建测试
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Debug -DCOMMATA_BUILD_TESTS=ON && \
    cmake --build . --config Debug -j$(nproc)

# 运行测试
CMD ["build/src_test/test_commata"]