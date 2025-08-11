FROM ubuntu:18.04

# 安装依赖项
RUN apt-get update && apt-get install -y \
    build-essential \
    qtbase5-dev \
    qt5-qmake \
    libqt5sql5-mysql \
    libqt5sql5-psql \
    libqt5sql5-sqlite \
    libmysqlclient-dev \
    postgresql-client \
    postgresql-contrib \
    lcov \
    git \
    && rm -rf /var/lib/apt/lists/*

# 设置工作目录
WORKDIR /app

# 复制源代码
COPY . /app

# 设置数据库
RUN service mysql start && \
    mysql -e "CREATE DATABASE qdjango_test;" -u root && \
    service mysql stop

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/10/main/pg_hba.conf && \
    echo "listen_addresses='*'" >> /etc/postgresql/10/main/postgresql.conf

# 启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]