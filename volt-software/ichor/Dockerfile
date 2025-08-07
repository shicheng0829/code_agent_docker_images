FROM ubuntu:jammy

# Install build dependencies
RUN apt update && apt install -y \
    g++-12 \
    gcc-12 \
    build-essential \
    cmake \
    pkg-config \
    git \
    wget \
    ninja-build \
    libzip-dev \
    libssl-dev \
    libsystemd-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up alternatives for gcc/g++
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 60
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 60
RUN update-alternatives --install /usr/bin/cpp cpp /usr/bin/cpp-12 60

# Environment variables for compilation
ENV CFLAGS="-O2 -fstack-protector-strong -fcf-protection -fstack-clash-protection -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3"
ENV CXXFLAGS="-O2 -std=c++20 -fstack-protector-strong -fcf-protection -fstack-clash-protection -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_FAST"
ENV LDFLAGS="-Wl,-z,nodlopen -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now"

# Download and build dependencies
WORKDIR /opt

# Download Boost
RUN wget https://boostorg.jfrog.io/artifactory/main/release/1.83.0/source/boost_1_83_0.tar.bz2

# Download OpenSSL
RUN wget https://www.openssl.org/source/openssl-3.0.11.tar.gz

# Download hiredis
RUN wget https://github.com/redis/hiredis/archive/refs/tags/v1.2.0.tar.gz

# Extract and build OpenSSL
RUN tar xf openssl-3.0.11.tar.gz
WORKDIR /opt/openssl-3.0.11
RUN ./Configure --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared
RUN make -j$(nproc)
RUN make -j$(nproc) install

# Extract and build Boost
WORKDIR /opt
RUN tar xf boost_1_83_0.tar.bz2
WORKDIR /opt/boost_1_83_0
RUN ./bootstrap.sh --prefix=/usr
RUN ./b2 variant=release link=static threading=multi cxxflags="-O2 -std=c++20 -fstack-protector-strong -fcf-protection -fstack-clash-protection -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_FAST" linkflags="-Wl,-z,nodlopen -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now"
RUN ./b2 variant=release link=static threading=multi cxxflags="-O2 -std=c++20 -fstack-protector-strong -fcf-protection -fstack-clash-protection -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_FAST" linkflags="-Wl,-z,nodlopen -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now" install

# Extract and build hiredis
WORKDIR /opt
RUN tar xf v1.2.0.tar.gz
RUN mkdir /opt/hiredis-1.2.0/build
WORKDIR /opt/hiredis-1.2.0/build
RUN cmake -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DDISABLE_TESTS=1 -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_SHARED_LIBS=OFF -DENABLE_SSL=1 ..
RUN ninja && ninja install

# Create directories for the source and build
RUN mkdir -p /opt/ichor/src
RUN mkdir -p /opt/ichor/build

# Set working directory
WORKDIR /opt/ichor/src

# Copy the source code
COPY . /opt/ichor/src

# Build and run tests
WORKDIR /opt/ichor/build
RUN cmake -GNinja -DCMAKE_BUILD_TYPE=Debug -DICHOR_USE_SANITIZERS=OFF -DICHOR_USE_BOOST_BEAST=ON -DICHOR_USE_SDEVENT=ON -DICHOR_USE_HIREDIS=ON -DICHOR_USE_SPDLOG=ON /opt/ichor/src
RUN cmake --build . --config Debug

# Default command to run tests
CMD ["ctest", "--output-on-failure"]