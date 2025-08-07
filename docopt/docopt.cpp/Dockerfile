FROM ubuntu:18.04

# 安装编译工具和依赖
RUN apt-get update && apt-get install -y \
    g++-7 \
    cmake \
    python3 \
    libboost-regex-dev \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目
RUN mkdir build && cd build && \
    cmake -DCMAKE_CXX_COMPILER=g++-7 -DWITH_TESTS=1 -DWITH_EXAMPLE=1 -DUSE_BOOST_REGEX=ON .. && \
    cmake --build . && \
    cp run_testcase ../ && \
    cp run_tests ../

WORKDIR /app/build

# 默认运行测试
CMD ["python3", "../run_tests"]

# 提供一个交互式shell作为替代入口点
ENTRYPOINT []