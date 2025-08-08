FROM ubuntu:20.04

# 避免交互式安装提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装基本依赖项
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      autoconf \
      automake \
      build-essential \
      cmake \
      curl \
      git \
      libgmp-dev \
      libmpfr-dev \
      libsqlite3-dev \
      ninja-build \
      openjdk-11-jdk \
      opam \
      pkg-config \
      python3 \
      python3-pip \
      rsync \
      unzip \
      wget \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# 设置Java环境变量
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# 创建非root用户
RUN useradd -m -s /bin/bash opam-user
USER opam-user
WORKDIR /home/opam-user

# 初始化opam
RUN opam init --reinit --bare --no-setup --disable-sandboxing && \
    opam switch create 5.3.0+flambda --package=ocaml-variants.5.3.0+options,ocaml-option-flambda && \
    opam switch set 5.3.0+flambda

# 将源代码复制到用户目录
USER root
COPY . /home/opam-user/infer
RUN chown -R opam-user:opam-user /home/opam-user/infer
USER opam-user

# 设置工作目录
WORKDIR /home/opam-user/infer

# 安装依赖项
RUN eval $(opam env) && \
    opam pin add --no-action ppx_show ./dependencies/ppx_show && \
    opam pin add --no-action pyml ./dependencies/pyml && \
    opam pin add --no-action camlzip ./dependencies/camlzip && \
    opam install --yes --deps-only ./opam/infer.opam.locked && \
    opam repo add local-llvm ./dependencies/llvm/opam-repository

# 构建Infer
RUN eval $(opam env) && \
    ./autogen.sh && \
    ./configure && \
    make -j$(nproc) opt

# 设置默认命令为运行测试
CMD ["bash", "-c", "eval $(opam env) && make test -k NDKBUILD=no"]