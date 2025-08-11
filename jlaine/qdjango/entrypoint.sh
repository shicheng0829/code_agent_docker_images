#!/bin/bash
set -e

# 启动 MySQL 服务
service mysql start

# 启动 PostgreSQL 服务
service postgresql start

# 创建 PostgreSQL 数据库和用户
sudo -u postgres psql -c "CREATE USER postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql -c "CREATE DATABASE qdjango_test;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE qdjango_test TO postgres;"

# 编译项目
mkdir -p build
cd build
qmake ..
make

# 运行测试
echo "Running SQLite memory tests..."
QDJANGO_DB_DRIVER=QSQLITE QDJANGO_DB_NAME=:memory: make check

echo "Running SQLite file tests..."
QDJANGO_DB_DRIVER=QSQLITE QDJANGO_DB_NAME=/tmp/qdjango_test.db make check

echo "Running MySQL tests..."
QDJANGO_DB_DRIVER=QMYSQL QDJANGO_DB_NAME=qdjango_test QDJANGO_DB_USER=root make check

echo "Running PostgreSQL tests..."
QDJANGO_DB_DRIVER=QPSQL QDJANGO_DB_NAME=qdjango_test QDJANGO_DB_USER=postgres QDJANGO_DB_PASSWORD=postgres make check

echo "All tests completed successfully!"