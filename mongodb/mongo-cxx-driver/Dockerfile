# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libssl-dev \
    pkg-config \
    python3 \
    wget \
    gnupg \
    systemd \
    && rm -rf /var/lib/apt/lists/*

# Install MongoDB Community Edition
RUN wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | apt-key add - \
    && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list \
    && apt-get update \
    && apt-get install -y mongodb-org \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project with tests enabled
RUN cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -DENABLE_TESTS=ON -DBUILD_TESTING=ON \
    && cmake --build build --parallel 64

# Expose MongoDB default port
EXPOSE 27017

# Start MongoDB and run tests
CMD mongod --fork --logpath /var/log/mongodb.log --bind_ip 127.0.0.1 && sleep 10 && cmake --build build --target test