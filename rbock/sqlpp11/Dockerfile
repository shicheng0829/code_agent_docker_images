FROM ubuntu:focal

# 避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装构建依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    clang \
    g++ \
    sqlite3 \
    libsqlite3-dev \
    libboost-dev \
    python3-pyparsing \
    mysql-client \
    libmysqlclient-dev \
    postgresql-client \
    libpq-dev \
    postgresql-server-dev-all \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . .

# 修改CMakeLists.txt以正确查找和链接线程库
RUN sed -i '/project(sqlpp11 VERSION 0.1 LANGUAGES CXX)/a find_package(Threads REQUIRED)' CMakeLists.txt && \
    sed -i 's/target_link_libraries(sqlpp11 INTERFACE date::date)/target_link_libraries(sqlpp11 INTERFACE date::date Threads::Threads)/' CMakeLists.txt

# 构建项目（启用所有连接器）
RUN cmake -B build \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_MYSQL_CONNECTOR=ON \
    -DBUILD_POSTGRESQL_CONNECTOR=ON \
    -DBUILD_SQLITE3_CONNECTOR=ON \
    -DBUILD_TESTING=ON \
    && cmake --build build -j$(nproc)

# 设置工作目录为构建目录
WORKDIR /app/build

# 运行测试
CMD ["ctest", "--output-on-failure"]