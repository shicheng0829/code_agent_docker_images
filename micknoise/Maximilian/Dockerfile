# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libasound2-dev \
    libpthread-stubs0-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Create a script to run tests
RUN echo '#!/bin/bash\n\
echo "Running Maximilian unit tests..."\n\
cd /app/cpp/commandline/tests\n\
\n\
# Run FFT test\n\
echo "Running FFT test..."\n\
cd ffttest\n\
mkdir -p build && cd build\n\
cmake ..\n\
make\n\
echo "FFT test compiled successfully."\n\
cd ../..\n\
\n\
# Run Kuramoto test\n\
echo "Running Kuramoto test..."\n\
cd kuratest\n\
mkdir -p build && cd build\n\
cmake ..\n\
make\n\
echo "Kuramoto test compiled successfully."\n\
cd ../..\n\
\n\
# Run MFCC test\n\
echo "Running MFCC test..."\n\
cd mfcctest\n\
mkdir -p build && cd build\n\
cmake ..\n\
make\n\
echo "MFCC test compiled successfully."\n\
cd ../..\n\
\n\
# Run Ring Buffer test\n\
echo "Running Ring Buffer test..."\n\
cd ringBufTest\n\
mkdir -p build && cd build\n\
cmake ..\n\
make\n\
echo "Ring Buffer test compiled successfully."\n\
cd ../..\n\
\n\
# Run SVF test\n\
echo "Running SVF test..."\n\
cd svftest\n\
mkdir -p build && cd build\n\
cmake ..\n\
make\n\
echo "SVF test compiled successfully."\n\
cd ../..\n\
\n\
echo "All tests compiled successfully!"\n'\
> /app/run-tests.sh && chmod +x /app/run-tests.sh

# Default command
CMD ["/app/run-tests.sh"]