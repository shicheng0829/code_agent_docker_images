# Development Dockerfile for frugally-deep
# Builds and runs unit tests

FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install system dependencies
RUN apt-get update -y --fix-missing && \
    apt-get install -y tzdata && \
    apt-get install -y \
    build-essential \
    cmake \
    python3 \
    python3-pip \
    git \
    libblas-dev \
    liblapack-dev \
    libatlas-base-dev \
    gfortran && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip
RUN pip3 install --upgrade pip

# Install Python dependencies
RUN pip3 install numpy scipy h5py "tensorflow==2.18.0" "keras==3.8.0"

# Clone and install C++ dependencies
WORKDIR /
RUN git clone -b 'v0.2.24' --single-branch --depth 1 https://github.com/Dobiasd/FunctionalPlus && \
    cd FunctionalPlus && \
    mkdir -p build && cd build && \
    cmake .. && \
    make && make install

RUN git clone -b '3.4.0' --single-branch --depth 1 https://gitlab.com/libeigen/eigen.git && \
    cd eigen && \
    mkdir -p build && cd build && \
    cmake .. && \
    make && make install && \
    ln -s /usr/local/include/eigen3/Eigen /usr/local/include/Eigen

RUN git clone -b 'v3.11.3' --single-branch --depth 1 https://github.com/nlohmann/json && \
    cd json && \
    mkdir -p build && cd build && \
    cmake -DJSON_BuildTests=OFF .. && \
    make && make install

RUN git clone -b 'v2.4.11' --single-branch --depth 1 https://github.com/onqtam/doctest.git && \
    cd doctest && \
    mkdir -p build && cd build && \
    cmake .. -DDOCTEST_WITH_TESTS=OFF -DDOCTEST_WITH_MAIN_IN_STATIC_LIB=OFF && \
    make && make install

# Copy project files
WORKDIR /frugally-deep
COPY . .

# Build and run unit tests
RUN mkdir -p build && cd build && \
    cmake .. -DFDEEP_BUILD_UNITTEST=ON && \
    cmake --build . --target unittest --config Release --

CMD ["bash"]