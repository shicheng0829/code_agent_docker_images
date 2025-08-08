FROM ubuntu:xenial

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download and install Python 3.9.23
RUN curl -O https://www.python.org/ftp/python/3.9.23/Python-3.9.23.tar.xz \
    && tar -xf Python-3.9.23.tar.xz \
    && cd Python-3.9.23 \
    && ./configure --enable-optimizations \
    && make -j$(nproc) \
    && make altinstall \
    && cd .. \
    && rm -rf Python-3.9.23 Python-3.9.23.tar.xz

# Install pip for Python 3.9
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && /usr/local/bin/python3.9 get-pip.py \
    && rm get-pip.py

# Install build tools
RUN pip3 install cmake conan==2.11.0

# Create non-root user
RUN useradd -m developer
USER developer
WORKDIR /home/developer

# Copy project files
COPY --chown=developer . /home/developer/icecream-cpp

WORKDIR /home/developer/icecream-cpp

# Install dependencies with Conan
RUN conan profile detect \
    && conan install ./tests --output-folder=build --build=missing

# Build the project with tests enabled
RUN cmake -DCMAKE_TOOLCHAIN_FILE=build/conan_toolchain.cmake \
          -DENABLE_RANGE_V3=ON \
          -DENABLE_FMT=ON \
          -DBUILD_TESTING=ON \
          -DCMAKE_CXX_FLAGS='-Wall -Wextra -Wconversion -Wshadow -pedantic -Werror' \
          -DCMAKE_BUILD_TYPE=Release . \
    && cmake --build . --config Release

CMD ["ctest", "-V"]