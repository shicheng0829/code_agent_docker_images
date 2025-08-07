# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt
# Also install system dependencies for audio processing and building C extensions
RUN apt-get update && apt-get install -y \
    libfftw3-dev \
    gcc \
    g++ \
    clang \
    cmake \
    libomp-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install pytest for running tests
RUN pip install --no-cache-dir pytest

# Build the audioFlux C library
RUN python setup.py build_py

# Command to run tests
CMD ["python", "-m", "pytest", "python/tests"]