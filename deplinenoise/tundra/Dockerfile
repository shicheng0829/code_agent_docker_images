FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建和测试所需的依赖项
RUN apt-get update && apt-get install -y \
    clang \
    make \
    perl \
    valgrind \
    yasm \
    cpanminus \
    asciidoc \
    source-highlight \
    git \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 安装Perl模块
RUN cpanm File::Slurp

# 验证Perl模块是否可用
RUN perl -MFile::Slurp -e 'print "File::Slurp loaded successfully\n";' && \
    perl -MDigest::MD5 -e 'print "Digest::MD5 loaded successfully\n";'

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 构建项目（包括单元测试）
RUN make all

# 默认命令：运行所有测试
CMD ["make", "run-all-tests"]