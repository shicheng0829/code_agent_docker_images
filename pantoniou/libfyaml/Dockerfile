FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      gcc autoconf automake libtool git make libyaml-dev libltdl-dev \
      pkg-config check && \
    rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 引导构建系统
RUN ./bootstrap.sh

# 配置项目
RUN ./configure

# 编译项目（不包括测试）
RUN make

# 提供交互式shell用于开发
CMD ["/bin/bash"]