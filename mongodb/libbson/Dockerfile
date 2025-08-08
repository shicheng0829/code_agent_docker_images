FROM ubuntu:16.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    autotools-dev \
    autoconf \
    libtool \
    pkg-config \
    clang \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /libbson

# Copy source code
COPY . .

# Build and test
RUN ./autogen.sh --enable-maintainer-flags && \
    make && \
    make test

CMD ["bash"]