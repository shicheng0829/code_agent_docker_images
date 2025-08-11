FROM ubuntu:18.04

# 避免在安装过程中出现交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    cmake \
    libicu-dev \
    git \
    g++ \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /opt/meta

# 复制本地源代码到容器中
COPY . .

# 初始化子模块
RUN git submodule update --init --recursive

# 修改CMakeLists.txt文件，注释掉所有与ICU相关的代码
RUN sed -i 's/include(deps\/meta-cmake\/FindOrBuildICU.cmake)/#include(deps\/meta-cmake\/FindOrBuildICU.cmake)/g' CMakeLists.txt && \
    sed -i 's/FindOrBuildICU/#FindOrBuildICU/g' CMakeLists.txt

# 创建构建目录
RUN mkdir build
WORKDIR /opt/meta/build

# 复制配置文件
RUN cp ../config.toml .

# 创建空的测试数据文件
RUN mkdir -p ../data && \
    touch ../data/empty.dat && \
    mkdir -p ../data/ceeaus && \
    touch ../data/ceeaus/ceeaus.dat

# 修改配置文件以使用空数据集
RUN sed -i 's/dataset = "ceeaus"/dataset = "empty"/g' config.toml && \
    sed -i 's/corpus = "line.toml"/corpus = "empty.toml"/g' config.toml

# 创建空的语料库配置文件
RUN echo 'type = "line"' > ../data/empty.toml && \
    echo 'dataset = "empty"' >> ../data/empty.toml && \
    echo 'training = "../data/empty.dat"' >> ../data/empty.toml

# 构建项目（排除所有外部下载和测试）
RUN cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTS=OFF -DDOWNLOAD_DATASETS=OFF -DDOWNLOAD_ICU=OFF
RUN make -j1

# 运行单元测试的命令
CMD ["ctest", "--output-on-failure"]