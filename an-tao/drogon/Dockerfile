FROM ubuntu:22.04

# 避免时区交互式配置
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装构建依赖项
RUN apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends \
    software-properties-common sudo curl wget cmake make pkg-config locales git \
    gcc-11 g++-11 openssl libssl-dev libjsoncpp-dev uuid-dev zlib1g-dev \
    libc-ares-dev postgresql-server-dev-all libmariadb-dev libsqlite3-dev \
    libhiredis-dev libbrotli-dev libspdlog-dev ninja-build \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

# 设置环境变量
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    CC=gcc-11 \
    CXX=g++-11 \
    AR=gcc-ar-11 \
    RANLIB=gcc-ranlib-11

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN ./build.sh -t

# 运行单元测试
CMD ["./test.sh", "-t"]