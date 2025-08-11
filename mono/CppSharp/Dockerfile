FROM ubuntu:22.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    cmake \
    curl \
    gcc-11 \
    g++-11 \
    git \
    libxml2-dev \
    make \
    ninja-build \
    python3 \
    tar \
    unzip \
    wget \
    xz-utils \
    zip \
    && rm -rf /var/lib/apt/lists/*

# 安装 .NET SDK
RUN curl -fsSL https://dot.net/v1/dotnet-install.sh | bash -s -- -c LTS --install-dir /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 下载Premake（如果尚未存在）
RUN build/build.sh install_tools

# 下载LLVM（带重试机制）
RUN for i in 1 2 3; do \
      echo "Attempt $i to download LLVM"; \
      build/build.sh download_llvm -platform x64 -configuration DebugOpt && break || \
      if [ $i -eq 3 ]; then exit 1; else sleep 10; fi; \
    done

# 生成项目文件
RUN build/build.sh generate -platform x64 -configuration DebugOpt

# 恢复NuGet包
RUN build/build.sh restore -platform x64 -configuration DebugOpt

# 构建项目
RUN build/build.sh -platform x64 -build_only -configuration DebugOpt

# 默认命令：运行单元测试
CMD ["build/test.sh", "-platform", "x64", "-configuration", "DebugOpt"]