# Use Ubuntu 22.04 as the base image, as it's a common LTS version
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
# Based on README.md and .travis.yml
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    doxygen \
    gcc \
    git \
    libssl-dev \
    make \
    perl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Copy the project files
COPY . .

# Initialize submodules recursively
# Based on README.md section on Git usage
RUN git submodule update --init --recursive

# Install Python requirements for testing
# Based on scripts/min_requirements.py and ci.requirements.txt
# Also install basic requirements for code generation
RUN python3 -m pip install --no-cache-dir -r scripts/ci.requirements.txt && \
    python3 -m pip install --no-cache-dir -r scripts/basic.requirements.txt

# Generate any necessary files
# Based on README.md section on generated files
RUN make generated_files

# Default command to run tests
CMD ["make", "check"]