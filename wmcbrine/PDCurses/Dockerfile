# Dockerfile for PDCurses development and testing

FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libx11-dev \
    libxaw7-dev \
    libxmu-dev \
    libxt-dev \
    libxext-dev \
    libxpm-dev \
    automake \
    autoconf \
    pkg-config \
    git \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the X11 version of PDCurses
RUN cd x11 && \
    ./configure --disable-widec && \
    make && \
    make demos

# Copy test script
COPY run-demo.sh /usr/local/bin/run-demo.sh
RUN chmod +x /usr/local/bin/run-demo.sh

# Default command runs all tests
CMD ["/usr/local/bin/run-demo.sh"]

# For running specific demos
# docker run --rm pdcurses-dev /usr/local/bin/run-demo.sh testcurs