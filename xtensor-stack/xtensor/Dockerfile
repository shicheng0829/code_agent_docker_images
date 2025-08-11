FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    ca-certificates \
    lsb-release \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Install LLVM and Clang (using version 18 as an example, similar to CI)
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 18 && \
    apt-get install -y clang-tools-18 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 200 && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 200 && \
    update-alternatives --install /usr/bin/clang-scan-deps clang-scan-deps /usr/bin/clang-scan-deps-18 200 && \
    update-alternatives --set clang /usr/bin/clang-18 && \
    update-alternatives --set clang++ /usr/bin/clang++-18 && \
    update-alternatives --set clang-scan-deps /usr/bin/clang-scan-deps-18 && \
    rm llvm.sh

# Install Miniconda
ENV CONDA_DIR=/opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh && \
    $CONDA_DIR/bin/conda clean -tip

# Accept Anaconda Terms of Service
RUN $CONDA_DIR/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    $CONDA_DIR/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r

# Copy environment files
COPY environment-dev.yml /tmp/environment-dev.yml

# Create conda environment
RUN conda env create -f /tmp/environment-dev.yml

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "xtensor", "/bin/bash", "-c"]

# Install additional packages that might be needed for building
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy the source code
COPY . .

# Configure using CMake
RUN cmake -G Ninja -Bbuild -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_INSTALL_PREFIX=$CONDA_DIR/envs/xtensor -DBUILD_TESTS=ON

# Install
RUN cd build && cmake --install .

# Build tests
RUN cd build && cmake --build . --target test_xtensor_lib --parallel 8

# Default command to run tests
CMD cd build && ctest -R ^xtest$ --output-on-failure