# Use Ubuntu as the base image (matching the CI configuration)
FROM ubuntu:jammy-20250619

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages for vcpkg development and testing
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # Basic utilities
    curl \
    zip \
    unzip \
    tar \
    ca-certificates \
    # Build essentials
    build-essential \
    git \
    # CMake for building vcpkg tool
    cmake \
    ninja-build \
    # Python for scripts
    python3 \
    python3-pip \
    # PowerShell for CI scripts
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PowerShell
RUN wget -q https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y powershell && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /vcpkg

# Copy the vcpkg source code
COPY . .

# Copy the test script
COPY run-tests.sh /run-tests.sh
RUN chmod +x /run-tests.sh

# Bootstrap vcpkg
RUN ./bootstrap-vcpkg.sh -skipDependencyChecks

# Verify vcpkg installation
RUN ./vcpkg version

# Default command to show help
CMD ["/run-tests.sh"]