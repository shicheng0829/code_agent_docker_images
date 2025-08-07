FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装必要的工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    gcc \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建基准测试程序
WORKDIR /app/bench
RUN make

# 构建碰撞测试程序
WORKDIR /app/collisions
RUN make

# 创建测试脚本
WORKDIR /app
RUN echo '#!/bin/bash\necho "Running rapidhash benchmark tests..."\ncd /app/bench\n./benchHash rapidhash rapidhashMicro rapidhashNano\necho "\nRunning rapidhash collision tests..."\ncd /app/collisions\n./collisionsTest --nbh=1000000 rapidhash\necho "\nAll tests completed successfully!"' > test.sh && chmod +x test.sh

# 默认命令
CMD ["/app/test.sh"]