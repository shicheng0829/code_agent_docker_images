# Use Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    wget \
    curl \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    libomp-dev \
    clang \
    llvm \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install --upgrade pip
RUN pip3 install numpy scipy pandas matplotlib scikit-learn pytest

# Create a non-root user
RUN useradd -m -u 1000 user
USER user
WORKDIR /home/user

# Clone and build XGBoost
COPY --chown=user . /home/user/xgboost
WORKDIR /home/user/xgboost

# Initialize and update submodules
RUN git submodule init && git submodule update

# Build XGBoost
RUN mkdir -p build && \
    cd build && \
    cmake .. -GNinja -DGOOGLE_TEST=ON -DUSE_DMLC_GTEST=ON && \
    ninja -v

# Set the default command to run tests
CMD ["ctest", "--test-dir", "build", "--output-on-failure"]