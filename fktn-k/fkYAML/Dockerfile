FROM ubuntu:20.04

# 避免在安装过程中出现交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码到容器中
COPY . .

# 构建项目和单元测试
RUN cmake -B build -DCMAKE_BUILD_TYPE=Debug -DFK_YAML_BUILD_TEST=ON \
    && cmake --build build --config Debug -j$(nproc)

# 默认运行单元测试
CMD ["./build/tests/unit_test/fkYAMLUnitTest"]

# 提供其他运行选项:
# 1. 运行所有测试: docker run --rm fkyaml-dev
# 2. 运行特定测试: docker run --rm fkyaml-dev ./build/tests/unit_test/fkYAMLUnitTest [test-name]
# 3. 交互式shell: docker run -it --rm fkyaml-dev bash