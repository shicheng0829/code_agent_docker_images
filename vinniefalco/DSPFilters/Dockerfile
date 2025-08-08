FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制项目文件
COPY . .

# 构建项目
RUN cd shared && mkdir build && cd build && \
    cmake .. && \
    make

# 设置环境变量以便更容易使用库
ENV LD_LIBRARY_PATH=/app/shared/build/DSPFilters:$LD_LIBRARY_PATH
ENV CPLUS_INCLUDE_PATH=/app/shared/DSPFilters/include:$CPLUS_INCLUDE_PATH

# 编译测试程序作为示例
RUN g++ -Ishared/DSPFilters/include -Lshared/build/DSPFilters -o test_filter test_filter.cpp -lDSPFilters

# 运行测试程序验证构建
RUN ./test_filter

# 提供一个默认的shell环境用于开发
CMD ["/bin/bash"]