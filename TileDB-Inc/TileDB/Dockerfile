# Ubuntu Docker file for TileDB Development and Testing

FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    zip \
    autoconf \
    automake \
    libtool \
    pkg-config \
    curl \
    unzip \
    git \
    python3 \
    python3-dev \
    python3-pip \
    libssl-dev \
    gdb \
    ninja-build \
    ccache \
    && apt-get clean \
    && apt-get purge -y \
    && rm -rf /var/lib/apt/lists* \
    && pip3 install cmake

# Setup environment
RUN useradd tiledb \
    && mkdir /home/tiledb \
    && chown tiledb /home/tiledb
ENV HOME /home/tiledb
WORKDIR /home/tiledb

# Copy TileDB source files
COPY . /home/tiledb/TileDB
RUN chown -R tiledb: /home/tiledb/TileDB

# Switch to tiledb user
USER tiledb

# Bootstrap and build TileDB
RUN cd /home/tiledb/TileDB \
    && mkdir build \
    && cd build \
    && ../bootstrap --enable-verbose --enable-assertions \
    && cmake --build . -j$(nproc) --target install \
    && cmake --build . -j$(nproc) --target tiledb_unit unit_vfs tiledb_regression all_link_complete

# Run tests
CMD ["sh", "-c", "cd /home/tiledb/TileDB/build && ./test/ci/test_assert -d yes && ./test/regression/tiledb_regression -d yes && ./test/tiledb_unit -d yes \"~[rapidcheck]\" && ./tiledb/sm/filesystem/test/unit_vfs -d yes"]