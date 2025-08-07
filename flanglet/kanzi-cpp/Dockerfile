FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    make \
    g++ \
    clang \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
WORKDIR /app/src
RUN make clean && make all

# 默认命令显示使用说明
CMD ["bash", "-c", "echo 'Usage:' && echo '  docker run --rm kanzi-dev ../bin/testBWT        # Run BWT test' && echo '  docker run --rm kanzi-dev ../bin/testTransforms  # Run transforms test' && echo '  docker run --rm kanzi-dev ../bin/testEntropyCodec # Run entropy codec test' && echo '  docker run --rm kanzi-dev ../bin/testDefaultBitStream # Run bitstream test' && echo '  docker run --rm kanzi-dev ../bin/testCompressedStream # Run compressed stream test' && echo '  docker run --rm kanzi-dev make test              # Build all test binaries' && echo '  docker run --rm -it kanzi-dev bash               # Interactive shell' && echo '' && echo 'Available test binaries in ../bin/:' && ls ../bin/test*"]