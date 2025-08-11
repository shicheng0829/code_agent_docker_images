# Development Dockerfile for Duktape
# Based on Ubuntu 20.04

FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone to Europe/Helsinki, some tests depend on it
RUN echo "Europe/Helsinki" > /etc/timezone && \
    rm -f /etc/localtime && \
    ln -s /usr/share/zoneinfo/Europe/Helsinki /etc/localtime

# Install required packages for building and testing Duktape
RUN apt-get update && apt-get install -y \
    build-essential \
    make \
    python3 \
    python3-yaml \
    python2 \
    git \
    curl \
    nodejs \
    npm \
    bc \
    valgrind \
    clang \
    tidy \
    zip \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16.x (required for some build scripts)
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Create working directory
WORKDIR /app

# Copy the source code
COPY . .

# Install Node.js dependencies
RUN npm install

# Pre-download some test dependencies to speed up test runs
RUN make runtestsdeps deps/linenoise deps/UglifyJS && \
    make deps/duktape-releases deps/lz-string deps/jquery-1.11.2.js && \
    make deps/luajs deps/underscore deps/lodash deps/bluebird.js deps/closure-compiler && \
    make clean

# Default command to run tests
CMD ["make", "test"]