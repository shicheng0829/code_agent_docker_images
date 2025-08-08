# Development Dockerfile for Trilogy
# This Dockerfile sets up an environment for building and testing Trilogy,
# a MySQL client library written in C.

FROM debian:bookworm

# Install build dependencies and MariaDB server for testing
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    curl \
    openssl \
    libssl-dev \
    default-mysql-client \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build the library and tests
RUN make test/test

# Expose MySQL port
EXPOSE 3306

# Default command runs tests (requires external MySQL server)
# To run tests successfully, you need to connect to a MySQL server
# You can do this by linking a MySQL container or connecting to an external server
CMD ["make", "test"]

# For development, you can run bash to work with the container:
# docker run -it trilogy-dev bash
#
# To run tests with an external MySQL server:
# docker run -e MYSQL_HOST=host.docker.internal trilogy-dev