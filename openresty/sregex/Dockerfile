FROM ubuntu:20.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    clang \
    make \
    bison \
    cpanminus \
    libipc-run3-perl \
    perl \
    && rm -rf /var/lib/apt/lists/*

# 安装Perl测试模块
RUN cpanm --notest Test::Base Test::LongString

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 创建Perl模块目录结构
# 这是为了让Perl能够找到测试模块t::SRegex
RUN mkdir -p /app/lib/t && \
    cp /app/t/SRegex.pm /app/lib/t/

# 构建项目
RUN make

# 设置Perl库路径，以便能找到测试模块
ENV PERL5LIB=/app/lib

# 默认运行测试
CMD ["make", "test"]