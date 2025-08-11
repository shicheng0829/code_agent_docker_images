FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gfortran \
    libcurl4-openssl-dev \
    automake \
    libtool \
    texinfo \
    python3 \
    python3-pip \
    python3-dev \
    git \
    pkg-config \
    libfreetype6-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install --upgrade pip
RUN pip3 install numpy==1.19.5 scipy==1.5.4 pillow
RUN pip3 install matplotlib==2.2.4

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the project
RUN cmake -DCMAKE_BUILD_TYPE=Release . && cmake --build .

# Default command
CMD ["./gradient_check", "--autosave=false", "check_synth2.config"]