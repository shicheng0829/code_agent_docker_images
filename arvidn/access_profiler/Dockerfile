FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建工具和依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    libboost-all-dev \
    libbfd-dev \
    libiberty-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 使用修复后的access_profiler.cpp文件
RUN cp access_profiler_fixed.cpp access_profiler.cpp

# 修复operator new声明问题
RUN sed -i '37s/size_t/std::size_t/' access_profiler.hpp

# 构建项目
RUN bjam

# 运行测试
CMD ["./bin/gcc-9/debug/test"]