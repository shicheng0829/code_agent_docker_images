FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
    build-essential \
    g++ \
    gfortran \
    cmake \
    git \
    python3-dev \
    python3-h5py \
    python3-pip \
    libboost-dev \
    libhdf5-dev \
    libmetis-dev \
    libopenmpi-dev \
    libscotch-dev \
    libtrilinos-amesos-dev \
    libtrilinos-amesos2-dev \
    libtrilinos-aztecoo-dev \
    libtrilinos-epetra-dev \
    libtrilinos-epetraext-dev \
    libtrilinos-ifpack-dev \
    libtrilinos-ml-dev \
    libtrilinos-teuchos-dev \
    libtrilinos-tpetra-dev \
    libtrilinos-kokkos-dev \
    libtrilinos-kokkos-kernels-dev \
    libtrilinos-shylu-dev \
    libsuitesparse-dev \
    libmedc-dev \
    openmpi-bin \
    wget

# Upgrade Pip
RUN python3 -m pip install --upgrade pip

# Install Python packages
RUN pip3 install numpy scipy sympy parameterized

# Set working directory
WORKDIR /app

# Copy Kratos source code
COPY . /app

# Create build directory
RUN mkdir -p /app/build

# Configure Kratos
RUN cmake -H"/app" -B"/app/build" \
    -DCMAKE_BUILD_TYPE="Release" \
    -DPYTHON_EXECUTABLE="/usr/bin/python3" \
    -DUSE_MPI=OFF \
    -DUSE_EIGEN_MKL=OFF \
    -DKRATOS_BUILD_TESTING=ON \
    -DKRATOS_GENERATE_PYTHON_STUBS=ON \
    -DKRATOS_APPLICATIONS="/app/applications/LinearSolversApplication;/app/applications/StructuralMechanicsApplication;/app/applications/FluidDynamicsApplication"

# Build Kratos
RUN cmake --build "/app/build" --target install -- -j$(nproc)

# Set environment variables for running tests
ENV PYTHONPATH="/app/bin/Release:$PYTHONPATH"
ENV LD_LIBRARY_PATH="/app/bin/Release/libs:$LD_LIBRARY_PATH"

# Default command
CMD ["/bin/bash"]