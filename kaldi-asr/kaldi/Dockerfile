# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV KALDI_ROOT=/opt/kaldi

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    wget \
    git \
    subversion \
    automake \
    autoconf \
    libtool \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libboost-all-dev \
    ca-certificates \
    gfortran \
    libatlas3-base \
    libatlas-base-dev \
    python3 \
    python3-pip \
    sox \
    flac \
    ffmpeg \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt

# Clone Kaldi repository
RUN git clone https://github.com/kaldi-asr/kaldi.git

# Set working directory to Kaldi
WORKDIR ${KALDI_ROOT}

# Install Kaldi tools
RUN cd tools && \
    extras/install_openblas.sh && \
    make -j$(nproc) && \
    cd ..

# Configure and build Kaldi
RUN cd src && \
    ./configure --shared && \
    make depend -j$(nproc) && \
    make -j$(nproc) && \
    cd ..

# Set environment variables
ENV PATH=${KALDI_ROOT}/src/bin:${KALDI_ROOT}/tools/openfst/bin:${KALDI_ROOT}/src/chainbin:${KALDI_ROOT}/src/featbin:${KALDI_ROOT}/src/fgmmbin:${KALDI_ROOT}/src/fstbin:${KALDI_ROOT}/src/gmmbin:${KALDI_ROOT}/src/ivectorbin:${KALDI_ROOT}/src/kwsbin:${KALDI_ROOT}/src/latbin:${KALDI_ROOT}/src/lmbin:${KALDI_ROOT}/src/nnet2bin:${KALDI_ROOT}/src/nnet3bin:${KALDI_ROOT}/src/nnetbin:${KALDI_ROOT}/src/online2bin:${KALDI_ROOT}/src/onlinebin:${KALDI_ROOT}/src/rnnlmbin:${KALDI_ROOT}/src/sgmm2bin:${KALDI_ROOT}/src/sgmmbin:${KALDI_ROOT}/src/tfrnnlmbin:${KALDI_ROOT}/src/cudadecoderbin:${KALDI_ROOT}/src/cudafeatbin:$PATH
ENV LC_ALL=C

# Create a test script to run unit tests
RUN echo '#!/bin/bash\ncd /opt/kaldi/src\necho "Running matrix tests..."\ncd matrix && make test\necho "Matrix tests completed."\n' > /opt/run_tests.sh && chmod +x /opt/run_tests.sh

# Set the default command
CMD ["/bin/bash"]