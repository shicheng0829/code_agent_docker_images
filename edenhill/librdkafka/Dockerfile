FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libssl-dev \
    libsasl2-dev \
    libzstd-dev \
    liblz4-dev \
    python3 \
    python3-pip \
    python3-venv \
    wget \
    rapidjson-dev \
    valgrind \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /librdkafka

# Copy the source code into the container
COPY . .

# Create a virtual environment and install Python dependencies for tests
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN cd tests && pip install -r requirements.txt

# Configure, build and install librdkafka
RUN ./configure --install-deps --enable-werror --enable-devel \
    && make -j all \
    && make -j -C tests build

# Default command to run tests
CMD ["make", "-C", "tests", "run_local_quick"]